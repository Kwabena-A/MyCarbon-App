import 'package:carbon_footprint/Widgets/user_Input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/constants.dart';
import '../data/values.dart';

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
              multiSelected.notifyListeners();
            }
          },
        );
      },
    );
  }
}