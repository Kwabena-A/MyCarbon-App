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
  Question("Whats your gender?", UserInputOptions.SINGLECHOICE, [
    "♂️ Male",
    "♀️ Female",
  ]),
  Question(
    "How would you categorize your body type?",
    UserInputOptions.SINGLECHOICE,
    ['😋 overweight', '🍔 obese', ' 🍟 underweight', '😐 normal'],
  ),
  Question("What does your diet look like?", UserInputOptions.MULTICHOICE, [
    '🍽️ omnivore',
    '🥚 vegetarian',
    '🌿 vegan',
    '🐟 pescatarian',
  ]),
  Question("How often do you shower per day?", UserInputOptions.SINGLECHOICE, [
    "Once",
    "Twice",
    "Three Times",
    "Shower?",
  ]),
  Question(
    "Whats your primary heating source?",
    UserInputOptions.SINGLECHOICE,
    ['🪓 wood', '🚂 coal', '⚡ electricity', '🏭 natural gas'],
  ),
  Question(
    "Whats your preferred mode of transport",
    UserInputOptions.SINGLECHOICE,
    ['🚌 public', '🚲 walk/bicycle', '🚗 private'],
  ),
  Question("Whats your vehicle type", UserInputOptions.SINGLECHOICE, [
    'none',
    '⛽ petrol',
    '⛽ diesel',
    '🎨 hybrid',
    '🧪 lpg',
    '⚡ electric',
  ]),
  Question("How socially active are you?", UserInputOptions.SINGLECHOICE, [
    '🛀 often',
    '🤢 never',
    '🧼 sometimes',
  ]),

  Question("Whats your monthly grocery bill?", UserInputOptions.MULTICHOICE, [
    'add number wheel',
    'quickly',
    'very fast',
  ]),
];