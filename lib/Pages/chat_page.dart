import 'package:carbon_footprint/Widgets/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/user_Input_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/speech_widget.dart';
import '../data/values.dart';

class Question {
  final String question;
  final UserInputOptions questionType;
  final List<String>? options;
  final (int, int)? range;
  late final UserInput widget;
  List<String>? response;

  Question({
    required this.question,
    required this.questionType,
    this.options,
    this.range,
  }) {
    if (questionType != UserInputOptions.NUMBER) {
      this.widget = UserInput(inputType: questionType, options: options!);
    } else {
      this.widget = UserInput(inputType: questionType, range: range!);
    }
  }

  void askQuestion() {
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
    response = (questionType == UserInputOptions.SINGLECHOICE)
        ? [singleSelected.value]
        : multiSelected.value;
    if (response != [""]) {
      if (currentQuestion.value < questionList.length - 1) {
        currentQuestion.value++;
        askCurrentQuestion();
      } else {
        for (Question question in questionList) {
          print(question.response);
        }
      }
    }
  }

  static void initConversation() {
    questionList.elementAt(0).askQuestion();
  }

  static void saveResponse() {
    questionList.elementAt(currentQuestion.value).getResponse();
  }

  static void askCurrentQuestion() {
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
      valueListenable: currentQuestion,
      builder: (context, value, child) {
        return Stack(
          children: [
            ConversationWidget(),
            questionList.elementAt(currentQuestion.value).widget,
          ],
        );
      },
    );
  }
}