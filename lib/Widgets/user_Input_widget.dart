import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Widgets/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/speech_widget.dart';
import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carbon_footprint/data/icons.dart';
import 'dart:math';

import '../data/values.dart';

enum UserInputOptions { NUMBER, MULTICHOICE, SINGLECHOICE }

class UserInput extends StatefulWidget {
  const UserInput({super.key, required this.inputType, required this.options});

  final UserInputOptions inputType;
  final List<String> options;

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  void resetSelected() {
    singleSelected.value = "";
    multiSelected.value = [];
  }

  @override
  Widget build(BuildContext context) {
    resetSelected();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(child: Container()),

        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: KConstants.KMainColor,
            ),
            child: SvgPicture.string(KIcons.confirm, color: Colors.white),
          ),
          onTap: () {
            conversation.value.add(
              SpeechInfo(
                SpeechSide.user,
                (widget.inputType == UserInputOptions.SINGLECHOICE)
                    ? singleSelected.value
                    : multiSelected.value.toString(),
              ),
            );
            conversation.notifyListeners();
            updateQuestion();
            resetSelected();
          },
        ),

        Choice(options: widget.options, optionType: widget.inputType),
        SizedBox(height: 130),
      ],
    );
  }
}

ValueNotifier<String> singleSelected = ValueNotifier("");
ValueNotifier<List<String>> multiSelected = ValueNotifier([]);

// Option Bubbles
class OptionBubble extends StatefulWidget {
  const OptionBubble({super.key, required this.text, required this.optionType});

  final String text;
  final UserInputOptions optionType;

  @override
  State<OptionBubble> createState() => _OptionBubbleState();
}

class _OptionBubbleState extends State<OptionBubble>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: (widget.optionType == UserInputOptions.SINGLECHOICE)
          ? singleSelected
          : multiSelected,
      builder: (context, value, child) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            decoration: BoxDecoration(
              color: (value.toString().contains(widget.text))
                  ? KConstants.KMainColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              widget.text,
              style: GoogleFonts.getFont(
                "Rubik",
                fontSize: 15,
                color: (value.toString().contains(widget.text))
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          onTap: () {
            if (widget.optionType == UserInputOptions.SINGLECHOICE) {
              singleSelected.value = (singleSelected.value != widget.text)
                  ? widget.text
                  : "";
            } else if (widget.optionType == UserInputOptions.MULTICHOICE) {
              if (!multiSelected.value.contains(widget.text)) {
                multiSelected.value.add(widget.text);
              } else {
                multiSelected.value.remove(widget.text);
              }
            }
            print(" Tapped on ${widget.text} ");
          },
        );
      },
    );
  }
}

String? currentlySelected;

// Single Choice
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
    int optionCount = widget.options.length;
    List<Row> rows = List.generate(
      (optionCount >= 3) ? (optionCount ~/ 3) + 1 : 1,
      (index) =>
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []),
    );
    for (int i = 0; i < widget.options.length; i++) {
      rows
          .elementAt((i ~/ 3))
          .children
          .add(
            OptionBubble(
              text: widget.options.elementAt(i),
              optionType: widget.optionType,
            ),
          );
    }

    List<Widget> spacedRows = [];
    for (Row row in rows) {
      spacedRows.add(Padding(padding: EdgeInsets.only(bottom: 10), child: row));
    }

    return Column(children: [...spacedRows]);
  }
}