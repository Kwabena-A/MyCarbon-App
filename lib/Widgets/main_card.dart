import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainCard extends StatefulWidget {
  const MainCard({super.key});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation; // Animation for progress bar

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    ); // tween for 0% to 70% progress

    _controller.forward(); // Start as soon as page is loaded

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20), // rounded-edges
        color: Colors.white,
      ),
      width: 280,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align from left
        children: [
          Text(
            "Carbon Kilograms / Year",
            style: GoogleFonts.getFont("Rubik", fontSize: 10),
          ),
          Text(
            "${(emissions.value != null) ? (emissions.value!.floor()) : "~"}",
            style: GoogleFonts.getFont(
              "Montserrat",
              fontSize: 55,
              fontWeight: FontWeight.bold,
              textStyle: TextStyle(height: 1),
            ),
          ),
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animation
                      .value, // Change progress based on animation value
                  backgroundColor: Color(0xFFe9e9e9),
                  color: Color(0xFF007223),
                  minHeight: 15,
                  borderRadius: BorderRadius.circular(8),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text.rich(
              TextSpan(
                style: GoogleFonts.getFont("Rubik", fontSize: 10),
                children: [
                  TextSpan(text: "Your score is"),
                  TextSpan(
                    text: " above average",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}