import 'dart:ui';

import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Widgets/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/speech_widget.dart';
import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carbon_footprint/data/icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/values.dart';
import 'option_buble_widget.dart';

enum UserInputOptions { NUMBER, MULTICHOICE, SINGLECHOICE }

class UserInput extends StatefulWidget {
  const UserInput({super.key, required this.inputType, required this.options});

  final UserInputOptions inputType;
  final List<String> options;

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

            AnimatedBuilder(
              animation: _confirmAnimation,
              builder: (context, child) {
                return GestureDetector(
                  // Confirm Widget
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _confirmAnimation.value,
                      ),
                      child: (isSelectedEmpty)
                          ? Text("Im not sure")
                          : Text(
                              "Submit",
                              style: GoogleFonts.getFont(
                                "Rubik",
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                  onTap: () {
                    // Presses Confirm
                    if (!isSelectedEmpty) {
                      conversation.value.add(
                        SpeechInfo(
                          SpeechSide.user,
                          (widget.inputType == UserInputOptions.SINGLECHOICE)
                              ? singleSelected.value
                              : multiSelected.value.toString(),
                        ),
                      );
                      conversation.notifyListeners();
                      Question.saveResponse();
                    } else {
                      conversation.value.add(
                        SpeechInfo(SpeechSide.user, "I'm not sure"),
                      );
                      conversation.notifyListeners();
                      Question.saveResponse();
                    }
                    resetSelected();
                  },
                );
              },
            ),

            Choice(options: widget.options, optionType: widget.inputType),
            SizedBox(height: 125),
          ],
        );
      },
    );
  }
}

class Choice extends StatefulWidget {
  final List<String> options;
  final UserInputOptions optionType;

  const Choice({super.key, required this.options, required this.optionType});

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    List<OptionBubble> optionBubbles = [];

    for (String optionText in widget.options) {
      OptionBubble optionWidget = OptionBubble(
        text: optionText,
        optionType: widget.optionType,
      );
      optionBubbles.add(optionWidget);
    }
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