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

    _animation = Tween<double>(
      begin: 0,
      end: 0,
    ).animate(_controller); // Basic init

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
    return ValueListenableBuilder(
      valueListenable: currentPage,
      builder: (context, value, child) {
        // Update progress bar with percentile value
        double percentileDouble = 0.0; // Finding Double value of percentile
        if (percentile.value != null) {
          // Percentile has a value
          // Removing st/nd/rd/th suffix
          int lastInt = 0;
          for (int i = 0; i < percentile.value!.length; i++) {
            try {
              int.parse(percentile.value![i]);
            } catch (e) {
              lastInt = i;
              break;
            }
          }

          print(percentile.value!.substring(0, lastInt));
          percentileDouble = double.parse(
            percentile.value!.substring(0, lastInt),
          );
          print(percentileDouble);
          _animation = Tween<double>(begin: 0, end: percentileDouble / 100)
              .animate(
                CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
              ); // tween for 0% to emissions percentile progress
        }

        _controller.reset();
        _controller.forward();
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
                        text: (percentile.value != null)
                            ? (percentileDouble > 60)
                                  ? " below average"
                                  : (percentileDouble > 40)
                                  ? " about average"
                                  : "above average"
                            : " ~",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}