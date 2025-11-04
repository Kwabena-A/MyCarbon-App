import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum SpeechSide { bot, user }

class SpeechWidget extends StatelessWidget {
  final SpeechSide side;
  final String text;

  const SpeechWidget({super.key, required this.side, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}