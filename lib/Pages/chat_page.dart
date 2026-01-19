import 'dart:io';

import 'package:carbon_footprint/Widgets/Conversation/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/Conversation/user_Input_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/Conversation/speech_widget.dart';
import '../data/values.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// Contains all question info
// Question.widget contains the UserInput widget, and is used in the Chat Page
class Question {
  final String question; // The string question
  final UserInputOptions questionType;
  final List<String>? options; // List of options (if a MCQ)
  final (int, int)? range; // range of scroll wheel (if a scroll wheel question)
  late final UserInput
  widget; // contains the UserInput widget, and is used in the Chat Page
  List<String>? response; // The users response,

  Question({
    required this.question,
    required this.questionType,
    this.options,
    this.range,
  }) {
    if (questionType != UserInputOptions.NUMBER) {
      // initialize UserInput widget based on question type
      this.widget = UserInput(inputType: questionType, options: options!);
    } else {
      this.widget = UserInput(inputType: questionType, range: range!);
    }
  }

  void askQuestion() {
    // Ran in askCurrentQuestion() when its index matches the currentQuestion value notifier
    conversation.value.add(
      SpeechInfo(
        side: SpeechSide.bot,
        text: question,
        questionIndex: questionList.indexOf(this),
      ),
    );
    conversation.notifyListeners();
  }

  void getResponse() {
    // Sets this.response to the current value of singleSelected or multiSelected
    // E.g. When called, whatever is selected will be set to this.response

    if (questionType == UserInputOptions.SINGLECHOICE) {
      response = [singleSelected.value];
    } else if (questionType == UserInputOptions.MULTICHOICE) {
      response = multiSelected.value;
    } else {
      while (scrollWheelSelected.value.remove(-1)) {}
      ;
      if (scrollWheelSelected.value.length == 0) {
        response = ["0"];
        return;
      }
      String strVal = "";
      for (int num in scrollWheelSelected.value) {
        strVal += "$num";
      }
      response = ["${int.parse(strVal)}"];
      print(response);
    }
  }

  static void askNextQuestions() async {
    if (currentQuestion.value < questionList.length - 1) {
      currentQuestion.value++; // Move to next question
      askCurrentQuestion();
    } else {
      // No more questions to ask
      List<String> args = []; // All questions responses will be save here
      for (Question question in questionList) {
        if (question.questionType != UserInputOptions.MULTICHOICE) {
          args.add(question.response![0]); // Add only element in list to args
        } else {
          args.add("${question.response}"); // Add all entire list to args
        }
      }
      var request = Uri.http(
        "spirit-facing-seminars-athens.trycloudflare.com", // Emission API URL
        "/make-prediction/",
        {"args": args},
      );

      var response = await http.get(request);
      if (response.statusCode == 200) {
        // Successfully Calculated
        var jsonResponse =
            convert.jsonDecode(response.body)
                as Map<String, dynamic>; // Convert to map
        emissions.value = double.parse(
          jsonResponse["prediction"].substring(
            1,
            jsonResponse["prediction"].length - 2,
          ),
        );
        conversation.value.add(
          SpeechInfo(side: SpeechSide.bot, text: "Your Prediction Is Ready!"),
        );
        conversation.value.add(
          SpeechInfo(
            side: SpeechSide.bot,
            text: "Your Emissions are ${emissions.value!.floor()} C kg/year",
          ),
        );
        conversation.value.add(
          SpeechInfo(side: SpeechSide.bot, text: "Return home to learn more."),
        );
      } else {
        conversation.value.add(
          SpeechInfo(
            side: SpeechSide.bot,
            text: "Sorry, their was an error when processing your information",
          ),
        );
        conversation.value.add(
          SpeechInfo(side: SpeechSide.bot, text: "Please contact kb rn asap"),
        );
      }
    }
    conversation.notifyListeners();
  }

  ValueNotifier getValueNotifier() {
    if (widget.inputType == UserInputOptions.SINGLECHOICE) {
      return singleSelected;
    } else if (widget.inputType == UserInputOptions.MULTICHOICE) {
      return multiSelected;
    } else {
      return scrollWheelSelected;
    }
  }

  static void initConversation() {
    // Ran in main to say the first question
    questionList.elementAt(0).askQuestion();
  }

  static void saveResponse() {
    // Ran when confirm button is pressed (on UserInput page)
    questionList.elementAt(currentQuestion.value).getResponse();
  }

  static void askCurrentQuestion() {
    // Ran every time a new question is promteds
    questionList.elementAt(currentQuestion.value).askQuestion();
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          currentQuestion, // Value listenable container index of current question
      builder: (context, value, child) {
        return Stack(
          children: [
            ConversationWidget(), // Contains text bubbles
            questionList
                .elementAt(currentQuestion.value)
                .widget, // Current question's UserInput Widget
          ],
        );
      },
    );
  }
}