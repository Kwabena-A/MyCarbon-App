import 'package:carbon_footprint/Widgets/main_card.dart';
import 'package:carbon_footprint/Widgets/user_behavior.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController =
      ScrollController(); // main scroll controller for homepage

  @override
  void initState() {
    scrollController.addListener(() {
      isScrolled.value =
          scrollController.position.pixels > 0; // Updated isScrolled
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Scroll widget
      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: 100), // Top and bottom padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MainCard(), // Top card showing Carbon Kilorgram per year
          UserBehavior(
            icon: "📖",
            header: "General",
            subHeader: "Your score is",
            score: "above average",
            content: ["♂️ Male", "😋 Overweight", "🍖 Omnivore"],
          ),
          UserBehavior(
            icon: "🧠",
            header: "Behavior",
            subHeader: "Your score is",
            score: "below average",
            content: [
              "🚿 2 Showers/Day",
              "👫 Frequently Social ",
              "📱 7 hours on internet",
              "⚡ Energy Conscious",
            ],
          ),
        ],
      ),
    );
  }
}