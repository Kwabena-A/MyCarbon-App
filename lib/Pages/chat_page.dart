import 'package:carbon_footprint/Widgets/Conversation/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/Conversation/user_Input_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/Conversation/speech_widget.dart';
import '../data/values.dart';

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
    response =
        (questionType == UserInputOptions.SINGLECHOICE) // set
        ? [singleSelected.value]
        : multiSelected.value;
    if (currentQuestion.value < questionList.length - 1) {
      currentQuestion.value++; // Move to next question
      askCurrentQuestion();
    } else {
      // No more questions to ask
      for (Question question in questionList) {
        print(question.response); // Print all responses
      }
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