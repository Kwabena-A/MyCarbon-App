// Nothing yet...

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/constants.dart';
import '../data/values.dart';
import 'dart:math';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  final int avgCarbonFootprint = 4730; // Will be useful when integrating UserInput
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
      padding: EdgeInsets.only(top: 120, bottom: 150),
      child: Column(
        children: [
          Container( // Top card showing percentile information
            height: 175,
            width: 400,
            margin: EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
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
                  "percentile for CO2 emissions per year",
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
                    title: '     Consumption',
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
          ),

          SizedBox(height: 10), // Space between pie chart and bar chart title

          // Bar Chart Title
          Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Text(
              "Your CO2 Emissions, Compared",
              style: GoogleFonts.getFont(
                "Rubik",
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Bar Chart + Y axis label
          Container(
            child: Row( // Aligning label and chart horizontally
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                // Y axis label
                SizedBox(
                  height: 625,
                  width: 100,
                  child: Padding(
                    // Aligning label to center of chart
                    padding: EdgeInsets.only(top: 90),
                    child: Center(

                      // Rotating label 90 degrees counter-clockwise
                      child: Transform.rotate(
                        angle: -pi / 2,
                        child: Text(
                          "CO2 Emissions per Person (tons)",

                          // Prevents text from wrapping
                          softWrap: false,

                          // Allows text to overflow outside of bounds if needed
                          overflow: TextOverflow.visible,
                          style: GoogleFonts.getFont(
                            "Rubik",
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center
                        ),
                      ),
                    ),
                  ),
                ),

                // Bar Chart
                Container(
                  height: 625,
                  width: 300,
                  child: BarChart(
                    BarChartData(
                        // Evenly spacing ear bar
                        alignment: BarChartAlignment.spaceAround,

                        // Setting Y axis range
                        maxY: 20,

                        // Makes each bar touchable, showing tooltip on touch
                        barTouchData: BarTouchData(
                          enabled: true,

                          // Tooltip i.e box that appears when bar is touched
                          touchTooltipData: BarTouchTooltipData(
                            tooltipBgColor: KConstants.KDarkGrayColor,
                          ),
                        ),

                        // Labels for each axis
                        titlesData: FlTitlesData(

                            // Number labels on left Y axis
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                      '${value.toInt()}',
                                  style: GoogleFonts.getFont(
                                    "Rubik",
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                  )
                                );
                                },
                              ),
                            ),

                            // Nothin on the right
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false
                                )
                            ),

                            // Country labels on bottom X axis
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return Container(
                                        child: Text(
                                          'China',
                                          style: GoogleFonts.getFont(
                                            "Rubik",
                                            fontSize: 14
                                          )
                                        ),
                                      );
                                    case 1:
                                      return Text('Brazil',
                                          style: GoogleFonts.getFont(
                                              "Rubik",
                                              fontSize: 14
                                          ));
                                    case 2:
                                      return Text('USA',
                                          style: GoogleFonts.getFont(
                                              "Rubik",
                                              fontSize: 14
                                          ));
                                    case 3:
                                      return Text('Europe',
                                          style: GoogleFonts.getFont(
                                              "Rubik",
                                              fontSize: 14
                                          ));
                                    case 4:
                                      return Text('India',
                                          style: GoogleFonts.getFont(
                                              "Rubik",
                                              fontSize: 14
                                          ));
                                    case 5:
                                      return Text('You',
                                          style: GoogleFonts.getFont(
                                              "Rubik",
                                              fontSize: 14,
                                              // Users are special and get a bold label
                                              fontWeight: FontWeight.bold
                                          ));
                                    default:
                                      return Text('');
                                  }
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: false
                                )
                            )
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),

                        // Bar data (toY means height of each bar)
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                                toY: 8.66,
                                color: Colors.black,
                                width: 20,
                                borderRadius: BorderRadius.zero // No rounded edges
                            )
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                                toY: 2.28,
                                color: Colors.black,
                                width: 20,
                                borderRadius: BorderRadius.zero
                            )
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                                toY: 14.2,
                                color: Colors.black,
                                width: 20,
                                borderRadius: BorderRadius.zero
                            )
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                                toY: 5.39,
                                color: Colors.black,
                                width: 20,
                                borderRadius: BorderRadius.zero
                            )
                          ]),
                          BarChartGroupData(x: 4, barRods: [
                            BarChartRodData(
                                toY: 2.2,
                                color: Colors.black,
                                width: 20,
                                borderRadius: BorderRadius.zero
                            )
                          ]),
                          BarChartGroupData(x: 5, barRods: [
                            BarChartRodData(
                                toY: 4,
                                color: KConstants.KMainColor,
                                width: 20,
                                borderRadius: BorderRadius.zero
                            )
                          ]),

                        ],

                        gridData: FlGridData(
                          show: true,
                          drawHorizontalLine: true, // Horizontal lines
                          drawVerticalLine: false,

                          // Styling for horizontal lines
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withOpacity(0.3),
                              strokeWidth: 1,
                              dashArray: null, // null means solid line
                            );
                          },
                        )
                    ),
                    ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}