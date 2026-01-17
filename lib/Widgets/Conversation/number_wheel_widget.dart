import 'dart:ui';

import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Unfinished
// Used for questiosn that require a number as a response
class NumberWheel extends StatefulWidget {
  const NumberWheel({super.key, required this.range});

  final (int, int) range;

  @override
  State<NumberWheel> createState() => _NumberWheelState();
}

class _NumberWheelState extends State<NumberWheel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 30,
      child: ClipRect(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              // Gradient behind numbers
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter, // Top to bottom gradient
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFFFF), // Transparent
                    KConstants.KDarkGrayColor,
                    KConstants.KDarkGrayColor,
                    KConstants.KDarkGrayColor,
                    Color(0xFFFFFF), // Transparent
                  ],
                ),
              ),
            ),

            ListWheelScrollView(
              // Number scroll wheel
              overAndUnderCenterOpacity: 0.5, // Top bottom fade out
              itemExtent: 25, // Size of each item
              physics: FixedExtentScrollPhysics(),
              children: [
                ...List.generate(widget.range.$2, (index) {
                  // Loop numbers from 1 to specified range
                  return Text(
                    "${widget.range.$1 + index}", // 1 - range
                    style: GoogleFonts.getFont("ABeeZee", fontSize: 20),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}