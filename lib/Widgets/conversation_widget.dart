import 'package:carbon_footprint/Widgets/speech_widget.dart';
import 'package:flutter/material.dart';

import '../data/values.dart';

// Contains the information neccesary to create a speech bubble
// Passed into List<SpeechInfo> conversation value notifier
class SpeechInfo {
  final SpeechSide side;
  final String text;
  static int totalQuestion = questionList.length;
  final int? questionIndex;

  SpeechInfo({required this.side, required this.text, this.questionIndex});
}

class ConversationWidget extends StatefulWidget {
  const ConversationWidget({super.key});

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: conversation,
      builder: (context, value, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 110),
                // Create a speechWidget for each element in 'conversation'
                ...List.generate(value.length, (index) {
                  return Container(
                    alignment: (value.elementAt(index).side == SpeechSide.bot)
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SpeechWidget(
                      side: value.elementAt(index).side,
                      text: value.elementAt(index).text,
                      questionIndex: value.elementAt(index).questionIndex,
                    ),
                  );
                }),

                SizedBox(height: 300),
              ],
            ),
          ),
        );
      },
    );
  }
}