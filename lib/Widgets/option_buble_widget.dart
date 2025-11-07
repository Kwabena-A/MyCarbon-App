import 'package:carbon_footprint/Widgets/user_Input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/constants.dart';
import '../data/values.dart';

// Option Bubbles, used when running a choice question
class OptionBubble extends StatefulWidget {
  const OptionBubble({super.key, required this.text, required this.optionType});

  final String text;
  final UserInputOptions optionType;

  @override
  State<OptionBubble> createState() => _OptionBubbleState();
}

class _OptionBubbleState extends State<OptionBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _animation = ColorTween(
      begin: Color(0xC6FFFFFF),
      end: KConstants.KMainColor,
    ).animate(_controller);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ValueListenableBuilder(
          valueListenable: (widget.optionType == UserInputOptions.SINGLECHOICE)
              ? singleSelected
              : multiSelected,
          builder: (context, value, child) {
            // Animates bubble color based on weather this option bubble is selected
            if (value.toString().contains(widget.text)) {
              if (_controller.status != AnimationStatus.forward) {
                _controller.forward();
              }
            } else {
              if (_controller.status != AnimationStatus.reverse) {
                _controller.reverse();
              }
            }

            return GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                  color: _animation.value,
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
                  // Set current selected to self if its a single choice question
                  singleSelected.value = (singleSelected.value != widget.text)
                      ? widget.text
                      : "";
                } else if (widget.optionType == UserInputOptions.MULTICHOICE) {
                  // Add/remove self in selected if its a multi choice question
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
      },
    );
  }
}