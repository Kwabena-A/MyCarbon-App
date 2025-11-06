import 'package:carbon_footprint/Widgets/speech_widget.dart';
import 'package:carbon_footprint/Widgets/user_Input_widget.dart';
import 'package:flutter/material.dart';

import '../data/values.dart';

class SpeechInfo {
  final SpeechSide side;
  final String text;
  static int totalQuestion = questionList.length;

  SpeechInfo(this.side, this.text);
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
                // Expanded(child: Container()),
                ...List.generate(value.length, (index) {
                  return Container(
                    alignment: (value.elementAt(index).side == SpeechSide.bot)
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SpeechWidget(
                      side: value.elementAt(index).side,
                      text: value.elementAt(index).text,
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