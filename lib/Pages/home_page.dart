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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      isScrolled.value = scrollController.position.pixels > 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 120),
          MainCard(),
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
          SizedBox(height: 120),
        ],
      ),
    );
  }
}