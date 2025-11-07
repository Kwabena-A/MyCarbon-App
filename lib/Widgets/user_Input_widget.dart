import 'dart:ui';

import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Widgets/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/speech_widget.dart';
import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/icons.dart';
import '../data/values.dart';
import 'number_wheel_widget.dart';
import 'option_buble_widget.dart';

enum UserInputOptions { NUMBER, MULTICHOICE, SINGLECHOICE }

class UserInput extends StatefulWidget {
  const UserInput({
    super.key,
    required this.inputType,
    this.options,
    this.range,
  });

  final UserInputOptions inputType;
  final List<String>? options;
  final (int, int)? range;

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput>
    with SingleTickerProviderStateMixin {
  late final AnimationController _confirmController;
  late final Animation _confirmAnimation;

  @override
  void initState() {
    _confirmController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _confirmAnimation = ColorTween(
      begin: KConstants.KDarkGrayColor,
      end: KConstants.KMainColor,
    ).animate(_confirmController);

    super.initState();
  }

  @override
  void dispose() {
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (widget.inputType == UserInputOptions.SINGLECHOICE)
          ? singleSelected
          : multiSelected,
      builder: (context, value, child) {
        bool isSelectedEmpty = value == "" || value.toString() == "[]";

        if (!isSelectedEmpty) {
          if (_confirmController.status != AnimationStatus.forward) {
            _confirmController.forward();
          }
        } else {
          if (_confirmController.status != AnimationStatus.reverse) {
            _confirmController.reverse();
          }
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Container()),

            // Submit/Idk Button
            AnimatedBuilder(
              animation: _confirmAnimation,
              builder: (context, child) {
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: _confirmAnimation.value,
                      ),

                      // set text based on if selected is empty
                      child: (isSelectedEmpty)
                          ? Text("I'm not sure")
                          : Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),

                  onTap: () {
                    // Presses Confirm
                    if (!isSelectedEmpty) {
                      // say user selection in chat
                      conversation.value.add(
                        SpeechInfo(
                          side: SpeechSide.user,
                          text:
                              (widget.inputType ==
                                  UserInputOptions.SINGLECHOICE)
                              ? singleSelected.value
                              : multiSelected.value.toString(),
                        ),
                      );
                      conversation.notifyListeners();

                      // Saves selected choice in current question
                      Question.saveResponse();
                    } else {
                      // User is not sure
                      conversation.value.add(
                        SpeechInfo(side: SpeechSide.user, text: "I'm not sure"),
                      );
                      conversation.notifyListeners();
                      Question.saveResponse();
                    }
                    resetSelected();
                  },
                );
              },
            ),

            // Based on questions user input options, a choiceWidget or NumberWheel widget is added
            (widget.inputType != UserInputOptions.NUMBER)
                ? Choice(options: widget.options!, optionType: widget.inputType)
                : NumberWheel(range: widget.range!),
            SizedBox(height: 125),
          ],
        );
      },
    );
  }
}

// Used to create optionBubble for choice questions
class Choice extends StatefulWidget {
  final List<String> options; // List of all options as strings
  final UserInputOptions optionType; // Single choice or multichoice

  const Choice({super.key, required this.options, required this.optionType});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    List<OptionBubble> optionBubbles = [];

    // Create an optionBubble for each option
    for (String optionText in widget.options) {
      OptionBubble optionWidget = OptionBubble(
        text: optionText,
        optionType: widget.optionType,
      );
      optionBubbles.add(optionWidget);
    }

    // Wraps each option bubble with padding
    List<Padding> spacedBubbles = List.generate(optionBubbles.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
        child: optionBubbles.elementAt(index),
      );
    });

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [...spacedBubbles],
          ),
        ),
      ],
    );
  }
}