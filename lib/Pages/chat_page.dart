import 'package:carbon_footprint/Widgets/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/user_Input_widget.dart';
import 'package:flutter/material.dart';

import '../Widgets/speech_widget.dart';
import '../data/values.dart';

class Question {
  final String question;
  final UserInputOptions questionType;
  final List<String> options;
  late final UserInput widget;
  List<String>? response;

  Question(this.question, this.questionType, this.options) {
    this.widget = UserInput(inputType: questionType, options: options);
  }

  UserInput prompt() {
    conversation.value.add(SpeechInfo(SpeechSide.bot, question));
    return this.widget;
  }

  void getResponse() {
    response = (questionType == UserInputOptions.SINGLECHOICE)
        ? [singleSelected.value]
        : multiSelected.value;
    if (response != [""]) {
      if (currentQuestion.value < questionList.length - 1) {
        currentQuestion.value++;
      } else {
        for (Question question in questionList) {
          print(question.response);
        }
      }
    }
  }
}

List<Question> questionList = [
  Question("Hows the whether?", UserInputOptions.SINGLECHOICE, [
    "Good",
    "Mid Fr",
    "Bad",
  ]),
  Question("What car do u drive", UserInputOptions.SINGLECHOICE, [
    "Toyota",
    "Prius",
    "Lenoir Car",
  ]),
  Question("What do u cook with?", UserInputOptions.SINGLECHOICE, [
    "Stove",
    "Pan",
    "Grill",
    "Yk, the usual",
  ]),
  Question("What Powers Your Home? ", UserInputOptions.SINGLECHOICE, [
    "Oil",
    "Gas",
    "Solar/Renwable",
    "ChatGPT",
  ]),
];

void updateQuestion() {
  questionList.elementAt(currentQuestion.value).getResponse();
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
            questionList.elementAt(value).prompt(),
          ],
        );
      },
    );
  }
}