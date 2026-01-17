import 'package:carbon_footprint/Widgets/Conversation/user_Input_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/constants.dart';
import '../../data/values.dart';

// Individual Option Bubbles, used when running a choice question
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
  late Animation _animation; // Green to Gray animation

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
    _animation = ColorTween(
      begin: Color(0xC6FFFFFF),
      end: KConstants.KMainColor,
    ).animate(_controller); // Tween between green and gray color

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
              : multiSelected, // Choose a value listenable based on whether its single or multichoice
          builder: (context, selected, child) {
            bool isSelected = selected.toString().contains(widget.text);

            // Animates bubble color based on weather this option bubble is selected
            if (isSelected) {
              // this option is in selected...
              if (_controller.status != AnimationStatus.forward) {
                // If not already animating
                _controller.forward(); // Animate to green
              }
            } else {
              if (_controller.status != AnimationStatus.reverse) {
                // If not already animating
                _controller.reverse(); // Animate to gray
              }
            }

            return GestureDetector(
              // For onTap attribute
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                  color: _animation
                      .value, // Change color based on _animation value
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  widget.text,
                  style: GoogleFonts.getFont(
                    "Rubik",
                    fontSize: 15,
                    color: (isSelected)
                        ? Colors.white
                        : Colors
                              .black, // if selected change text color to white, else black
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
                  multiSelected
                      .notifyListeners(); // Update listeners for Multiselected
                }
              },
            );
          },
        );
      },
    );
  }
}