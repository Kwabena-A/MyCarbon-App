import 'dart:ui';

import 'package:carbon_footprint/data/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Unfinished

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
      // color: Colors.red,
      height: 100,
      child: ClipRect(
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFF),
                KConstants.KMainGrayColor,
                KConstants.KMainGrayColor,
                KConstants.KMainGrayColor,
                Color(0xFFFFFF),
              ],
            ).createShader(bounds);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 30,
                height: double.infinity,
                color: KConstants.KDarkGrayColor,
              ),
              ListWheelScrollView(
                overAndUnderCenterOpacity: 0.5,
                itemExtent: 25,
                physics: FixedExtentScrollPhysics(),
                children: [
                  ...List.generate(widget.range.$2, (index) {
                    return Text(
                      "${index + 1}",
                      style: GoogleFonts.getFont("ABeeZee", fontSize: 20),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}