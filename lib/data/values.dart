import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:flutter/cupertino.dart';

import '../Widgets/Conversation/conversation_widget.dart';
import '../Widgets/Conversation/speech_widget.dart';
import '../Widgets/Conversation/user_Input_widget.dart';

ValueNotifier<double?> emissions = ValueNotifier(
  null,
); // Calculated and Returned by API
ValueNotifier<String?> percentile = ValueNotifier(
  null,
); // Calculated and Returned by API

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
    question: "How would you categorize your body type?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['overweight', 'obese', 'underweight', 'normal'],
  ),
  Question(
    question: "Whats your gender?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ["male", "female"],
  ),
  Question(
    question: "What does your diet look like?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['omnivore', 'vegetarian', 'vegan', 'pescatarian'],
  ),
  Question(
    question: "How often do you shower per day?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 3),
  ),
  Question(
    question: "Whats your primary heating source?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['wood', 'coal', 'electricity', 'natural gas'],
  ),
  Question(
    question: "Whats your preferred mode of transport",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['public', 'walk/bicycle', 'private'],
  ),
  Question(
    question: "Whats your vehicle type",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['none', 'petrol', 'diesel', 'hybrid', 'lpg', 'electric'],
  ),
  Question(
    question: "How socially active are you?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['often', 'never', 'sometimes'],
  ),

  Question(
    question: "Whats your monthly grocery bill? (\$)",
    questionType: UserInputOptions.NUMBER,
    range: (0, 9999),
  ),
  Question(
    question: "How frequently do you travel by air?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['frequently', 'rarely', 'never', 'very frequently'],
  ),

  Question(
    question: "Whats your monthly travel distances? (km)",
    questionType: UserInputOptions.NUMBER,
    range: (0, 9999),
  ),

  Question(
    question: "What size waste bags do you use?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['large', 'extra large', 'small', 'medium'],
  ),

  Question(
    question: "How many waste bags do you use per week?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 50),
  ),

  Question(
    question: "During a day, how many hours do you spend on the TV and PC?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 24),
  ),

  Question(
    question: "How many new clothes do you buy monthly?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 100),
  ),

  Question(
    question: "How long do you spend on the internet per day?",
    questionType: UserInputOptions.NUMBER,
    range: (0, 24),
  ),

  Question(
    question: "Do you prioritize energy efficient devices?",
    questionType: UserInputOptions.SINGLECHOICE,
    options: ['No', 'Sometimes', 'Yes'],
  ),

  Question(
    question: "Which objects do you primarily recycle?",
    questionType: UserInputOptions.MULTICHOICE,
    options: ["Metal", "Paper", "Plastic", "Glass"],
  ),

  Question(
    question: "What do you cook with?",
    questionType: UserInputOptions.MULTICHOICE,
    options: ["Microwave", "Airfryer", "Stove", "Oven", "Grill"],
  ),

  Question(
    question: "Your Done!",
    questionType: UserInputOptions.NONE,
    options: [" "],
  ),
];