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
  late Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _animation = ColorTween(
      begin: Color(0xFFF8F7F7),
      end: Colors.white,
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
    return ValueListenableBuilder(
      valueListenable: isScrolled,
      builder: (context, isScrolledValue, child) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            if (isScrolledValue) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            return Container(
              color: _animation.value,
              child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(child: SvgPicture.string(KIcons.menu)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: TitlePill(),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.string(KIcons.share),
                          SvgPicture.string(KIcons.settings),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class TitlePill extends StatelessWidget {
  const TitlePill({super.key});
  static List<String> pageTitles = ["Home", "Chat", "Statistics"];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, page, child) {
        return Text(
          pageTitles.elementAt(page),
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