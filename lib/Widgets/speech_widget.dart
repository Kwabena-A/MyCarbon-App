import 'package:carbon_footprint/data/constants.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Passed to identify which side a speech widget should be on
enum SpeechSide { bot, user }

class SpeechWidget extends StatelessWidget {
  final SpeechSide side;
  final String text;
  final int? questionIndex;

  const SpeechWidget({
    super.key,
    required this.side,
    required this.text,
    this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: (side == SpeechSide.bot)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: (side == SpeechSide.user)
                ? KConstants.KMainColor
                : KConstants.KDarkGrayColor,
            borderRadius: BorderRadius.only(
              bottomLeft: (side == SpeechSide.user)
                  ? Radius.circular(13)
                  : Radius.circular(0),
              bottomRight: (side == SpeechSide.bot)
                  ? Radius.circular(13)
                  : Radius.circular(0),
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
          ),

          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),

          child: Text(
            text,
            style: GoogleFonts.getFont(
              "ABeeZee",
              fontSize: 15,
              color: (side == SpeechSide.user) ? Colors.white : Colors.black,
            ),
          ),
        ),

        // Question Counter, if null nothing is passed
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          alignment: Alignment.topLeft,
          child: (questionIndex != null)
              ? Text(
                  "${questionIndex! + 1}/${questionList.length}",
                  style: GoogleFonts.getFont(
                    "ABeeZee",
                    fontSize: 10,
                    color: Colors.black,
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}