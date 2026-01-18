import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

import '../Widgets/Conversation/conversation_widget.dart';
import '../Widgets/Conversation/speech_widget.dart';
import '../Widgets/Conversation/user_Input_widget.dart';

ValueNotifier currentPage = ValueNotifier(0); // Changes based on current page
ValueNotifier isScrolled = ValueNotifier(false); // Changes when user scrolls

ValueNotifier<List<SpeechInfo>> conversation = ValueNotifier([
  SpeechInfo(side: SpeechSide.bot, text: "Welcome!"),
]); // Contains SpeechInfo objects for each speech bubble in live conversation

ValueNotifier<int> currentQuestion = ValueNotifier(
  0,
); // Changes based on current question

// Resets selected options
void resetSelected() {
  singleSelected.value = "";
  multiSelected.value = [];
  scrollWheelSelected.value = List.generate(10, (index) => -1);
}

ValueNotifier<String> singleSelected = ValueNotifier(
  "",
); // Used to track selected option for single choice questions
ValueNotifier<List<String>> multiSelected = ValueNotifier(
  [],
); // Used to track selected options for multi choice questions

ValueNotifier<List<int>> scrollWheelSelected = ValueNotifier(
  List.generate(10, (index) => -1),
);

// List of all questions, iterated through to ask questions
final List<Question> questionList = [
  Question(
    question: "Whats your gender?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ["♂️ Male", "♀️ Female"],
  ),
  Question(
    question: "How would you categorize your body type?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['😋 overweight', '🍔 obese', ' 🍟 underweight', '😐 normal'],
  ),
  Question(
    question: "What does your diet look like?",
    questionType: UserInputOptions.MULTICHOICE,
    options: ['🍽️ omnivore', '🥚 vegetarian', '🌿 vegan', '🐟 pescatarian'],
  ),
  Question(
    question: "How often do you shower per day?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 3),
  ),
  Question(
    question: "Whats your primary heating source?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['🪓 wood', '🚂 coal', '⚡ electricity', '🏭 natural gas'],
  ),
  Question(
    question: "Whats your preferred mode of transport",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['🚌 public', '🚲 walk/bicycle', '🚗 private'],
  ),
  Question(
    question: "Whats your vehicle type",
    questionType: UserInputOptions.SINGLECHOICE,
    options: [
      'none',
      '⛽ petrol',
      '⛽ diesel',
      '🎨 hybrid',
      '🧪 lpg',
      '⚡ electric',
    ],
  ),
  Question(
    question: "How socially active are you?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['🛀 often', '🤢 never', '🧼 sometimes'],
  ),

  Question(
    question: "Whats your monthly grocery bill?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 5000),
  ),
];