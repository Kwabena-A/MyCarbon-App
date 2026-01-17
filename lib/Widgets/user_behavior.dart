import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserBehavior extends StatefulWidget {
  const UserBehavior({
    super.key,
    required this.icon,
    required this.header,
    required this.subHeader,
    required this.score,
    required this.content,
  });

  final String icon;
  final String header;
  final String subHeader;
  final String score;
  final List<String> content;

  @override
  State<UserBehavior> createState() => _UserBehaviorState();
}

class _UserBehaviorState extends State<UserBehavior> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Containing Icon
          Column(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    widget.icon, // Emoji
                    style: TextStyle(height: 1, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(height: 9),

              // Dotted line (a small dot based on how many content blocks their are)
              ...List.generate(widget.content.length * 6, (index) {
                double radius = 5;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Container(
                    height: radius,
                    width: radius,
                    decoration: BoxDecoration(
                      color: Color(0xFFe9e9e9),
                      borderRadius: BorderRadius.circular(radius / 2),
                    ),
                  ),
                );
              }),
            ],
          ),
          SizedBox(width: 10),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child: Text(
                  widget.header,
                  style: GoogleFonts.getFont(
                    "Rubik",
                    fontSize: 15,
                    textStyle: TextStyle(
                      height: 0.8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Text.rich(
                // For partial bolding
                TextSpan(
                  style: TextStyle(fontSize: 13),
                  children: [
                    TextSpan(text: widget.subHeader),
                    TextSpan(
                      text: " ${widget.score}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),

              // Content blocks
              ...List.generate(widget.content.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    width: 220,
                    decoration: BoxDecoration(
                      color: Color(0xFFe9e9e9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 17.0,
                        horizontal: 15,
                      ),
                      child: Text(
                        textAlign: TextAlign.left,
                        widget.content.elementAt(index),
                        style: GoogleFonts.getFont("Rubik", fontSize: 13),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}