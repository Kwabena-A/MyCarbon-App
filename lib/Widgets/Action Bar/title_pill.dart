import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/values.dart';

// Menu title text
class TitlePill extends StatelessWidget {
  const TitlePill({super.key});
  static List<String> pageTitles = ["Home", "Chat", "Statistics"];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage, // Value listenable to track current page
      builder: (context, pageIndex, child) {
        return Text(
          pageTitles.elementAt(
            pageIndex,
          ), // Update text based on current page index
          style: GoogleFonts.getFont(
            "Poppins",
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }
}