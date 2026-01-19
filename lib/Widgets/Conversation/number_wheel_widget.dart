import 'dart:math';
import 'dart:ui';

import 'package:carbon_footprint/data/constants.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Used for questiosn that require a number as a response
class NumberWheel extends StatefulWidget {
  const NumberWheel({super.key, required this.range});

  final (int, int) range;

  @override
  State<NumberWheel> createState() => _NumberWheelState();
}

class _NumberWheelState extends State<NumberWheel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int scrollWheelCount = 1; // Number of scroll wheels
    while (widget.range.$2 / pow(10, scrollWheelCount) > 1) {
      scrollWheelCount++;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(scrollWheelCount, (index) {
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
                    onSelectedItemChanged: (value) {
                      scrollWheelSelected.value[(scrollWheelCount - 1) -
                              index] =
                          value;
                    },
                    overAndUnderCenterOpacity: 0.5, // Top bottom fade out
                    itemExtent: 25, // height of each item
                    physics: FixedExtentScrollPhysics(),
                    children: [
                      ...List.generate(
                        ((index == scrollWheelCount - 1)
                            ? (widget.range.$2 / pow(10, scrollWheelCount - 1))
                                      .floor() +
                                  1
                            : 10),
                        (numIndex) {
                          scrollWheelSelected.value[(scrollWheelCount - 1) -
                                  index] =
                              0;
                          // Loop numbers from 1 to specified range
                          return Text(
                            "${numIndex}", // 1 - range
                            style: GoogleFonts.getFont("ABeeZee", fontSize: 20),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).reversed,
      ],
    );
  }
}