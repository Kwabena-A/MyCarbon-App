// Nothing yet...

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/values.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  final int avgCarbonFootprint = 4000; // Will be useful when integrating UserInput
  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  ScrollController scrollController =
  ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      isScrolled.value =
          scrollController.position.pixels > 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      controller: scrollController,
      padding: EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          Container( // Top card showing percentile information
            height: 175,
            width: 400,
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // rounded-edges
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You are in the",
                  style: GoogleFonts.getFont("Rubik", fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  "84th",
                  style: GoogleFonts.getFont(
                    "Montserrat",
                    fontSize: 55,
                    fontWeight: FontWeight.bold,
                    textStyle: TextStyle(height: 1),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "percentile for carbon emissions",
                  style: GoogleFonts.getFont("Rubik", fontSize: 20),
                ),
              ],
            )
          ),
          // Lil bit of space between card and pie chart title
          SizedBox(height: 10),

          // Pie Chart Title
          Text(
            "Carbon Footprint Breakdown",
            style: GoogleFonts.getFont(
              "Rubik",
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 425,
            width: 100,
            child: PieChart( // Pie chart showing carbon footprint breakdown
              PieChartData(
                sections: [ // Pie chart sections
                  PieChartSectionData(
                    value:  30, // Values per section should add up to 100
                    color: Colors.green,
                    title: 'Food',
                    radius: 182, // Used to adjust size (make sure all sections have the same radius)
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PieChartSectionData(
                    value: 70,
                    color: Colors.blue,
                    title: 'Transportation',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                sectionsSpace: 10, // Determines gap between one section and another (0 means the different colors touch)
                centerSpaceRadius: 0 // Determines if the pie chart has a hole (0 means no hole)
              ),
            ),
          )
        ],
      ),
    );
  }
}