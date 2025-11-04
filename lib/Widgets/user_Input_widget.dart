import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Widgets/conversation_widget.dart';
import 'package:carbon_footprint/Widgets/speech_widget.dart';
import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carbon_footprint/data/icons.dart';

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

class _UserInputState extends State<UserInput> {
  @override
  Widget build(BuildContext context) {
    resetSelected();

    return ValueListenableBuilder(
      valueListenable: (widget.inputType == UserInputOptions.SINGLECHOICE)
          ? singleSelected
          : multiSelected,
      builder: (context, value, child) {
        bool isSelectedEmpty = value == "" || value == [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: Container()),

            GestureDetector(
              // Confirm Widget
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (isSelectedEmpty)
                        ? KConstants.KDarkGrayColor
                        : KConstants.KMainColor,
                  ),
                  child: (isSelectedEmpty)
                      ? SvgPicture.string(KIcons.question)
                      : SvgPicture.string(KIcons.confirm, color: Colors.white),
                ),
              ),
              onTap: () {
                bool isSelectedEmpty =
                    (widget.inputType == UserInputOptions.SINGLECHOICE)
                    ? (value == "")
                    : (value == []);
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
                  saveResponse();
                  resetSelected();
                } else {
                  print("User not sure");
                  conversation.value.add(
                    SpeechInfo(SpeechSide.user, "I'm not sure"),
                  );
                  conversation.notifyListeners();

                  value = "";
                  conversation.notifyListeners();
                  saveResponse();
                  resetSelected();
                }
              },
            ),

            Choice(options: widget.options, optionType: widget.inputType),
            SizedBox(height: 130),
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