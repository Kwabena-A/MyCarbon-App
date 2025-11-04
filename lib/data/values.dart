import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

import '../Widgets/conversation_widget.dart';
import '../Widgets/speech_widget.dart';
import '../Widgets/user_Input_widget.dart';

ValueNotifier currentPage = ValueNotifier(0);
ValueNotifier isScrolled = ValueNotifier(false);

ValueNotifier<List<SpeechInfo>> conversation = ValueNotifier([
  SpeechInfo(SpeechSide.bot, "Welcome!"),
]);

ValueNotifier<int> currentQuestion = ValueNotifier(0);

void resetSelected() {
  singleSelected.value = "";
  multiSelected.value = [];
}

ValueNotifier<String> singleSelected = ValueNotifier("");
ValueNotifier<List<String>> multiSelected = ValueNotifier([]);

final List<Question> questionList = [
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
  Question("What do u cook with?", UserInputOptions.MULTICHOICE, [
    "Stove",
    "Pan",
    "Grill",
    "Yk, the usual",
  ]),
  Question("What Powers Your Home? ", UserInputOptions.MULTICHOICE, [
    "Oil",
    "Gas",
    "Solar/Renwable",
    "ChatGPT",
  ]),
];