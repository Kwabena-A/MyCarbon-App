import 'dart:ui';

import 'package:carbon_footprint/Widgets/Action%20Bar/title_pill.dart';
import 'package:carbon_footprint/data/constants.dart';
import 'package:carbon_footprint/data/icons.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionBar extends StatefulWidget {
  const ActionBar({super.key});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation; // Color animation for action bar background

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = ColorTween(
      begin: Color(0xFFFFFF), // Transparent
      end: Colors.white,
    ).animate(_controller); // Tween between transparent and white

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
          isScrolled, // Value listenable that tracks whether user has scrolled
      builder: (context, isScrolledValue, child) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (isScrolledValue) {
              // If user scrolled
              if (_controller.status != AnimationStatus.forward) {
                _controller.forward(); // Animate to white
              }
            } else {
              if (_controller.status != AnimationStatus.reverse) {
                _controller.reverse(); // Animate to transparent
              }
            }

            return Container(
              color: _animation.value, // Change color based on _animation value
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: SvgPicture.string(KIcons.menu)), // Menu Icon
                  // Menu Name Bubble
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: TitlePill(), // Contains and updates menu name text
                  ),

                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.string(KIcons.share), // Share Icon
                        SvgPicture.string(KIcons.settings), // Settings
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}