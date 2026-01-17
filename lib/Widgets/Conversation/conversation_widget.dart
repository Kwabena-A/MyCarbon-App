import 'package:carbon_footprint/Widgets/Conversation/speech_widget.dart';
import 'package:flutter/material.dart';

import '../../data/values.dart';

// Contains the information neccesary to create a speech bubble
// Passed into List<SpeechInfo> conversation value notifier
class SpeechInfo {
  final SpeechSide side; // enum for Which side the text should appear on
  final String text; // Text displayed
  final int?
  questionIndex; // Current question index, (used for progress indicator)

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
      valueListenable:
          conversation, // Value listenable containing every active/visible chat message as a SpeechInfo object
      builder: (context, conversationList, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20), // Horizantal padding
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 100, bottom: 300),
            reverse: true, // Force follow the bottom of the conversation
            child: Column(
              children: [
                // Loop to create a speechWidget for each SpeechInfo object in 'conversation'
                ...List.generate(conversationList.length, (index) {
                  return Container(
                    alignment:
                        (conversationList.elementAt(index).side ==
                            SpeechSide.bot)
                        ? Alignment.centerLeft
                        : Alignment
                              .centerRight, // Set alignment based on SpeachInfo.side
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ), // Padding between text
                    child: SpeechWidget(
                      // Creating a speech widget using object attributes
                      side: conversationList.elementAt(index).side,
                      text: conversationList.elementAt(index).text,
                      questionIndex: conversationList
                          .elementAt(index)
                          .questionIndex,
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}