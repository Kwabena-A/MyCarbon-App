// Nothing yet...

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/constants.dart';
import '../data/values.dart';
import 'dart:math';

final int avgCarbonFootprint = 4730; // Will be useful when integrating UserInput
double userEmissions = 0;
double bodyTypeEmissions = 0; // Q0 response
double dietEmissions = 0; // Q2 response
double heatingEmissions = 0; // Q4 response
double transportModeEmissions = 0; // Q5 response
double vehicleTypeEmissions = 0; // Q6 response
double socialEmissions = 0; // Q7 response
double airTravelEmissions = 0; // Q9 response
double wasteBagEmissions = 0; // Q11 response
double energyEfficientDevicesEmissions = 0; // Q16 response
double cookingEmissions = 0; // Q18 response
double otherEmissions = 0; // For unaccounted emissions
String percentile = "";




class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});
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

    emissionsCalc();
    super.initState();
  }

void emissionsCalc() {
  for (int i = 0; i < questionList.length; i++) {
    String response = questionList[i].response.toString();
    switch (i) {

      // The Body Type Question
      case 0:
        if (response.contains("overweight")) {
          // 15% more than default
          bodyTypeEmissions = avgCarbonFootprint * (12.5 * 1.15 / 100);
        }

        else if (response.contains("obese")) {
          // 20% more than default
          bodyTypeEmissions = avgCarbonFootprint * (12.5 * 1.2 / 100);
        }

        else if (response.contains("underweight")) {
          // 15% less than default
          bodyTypeEmissions = avgCarbonFootprint * (12.5 * 0.85 / 100);
        }

        else {
          /*
           * Diet takes about 25% of avg carbon footprint, but we split it across body type and diet
           * This is because body type can affect diet-related emissions
           */
          bodyTypeEmissions = avgCarbonFootprint * 0.125;
        }

        userEmissions += bodyTypeEmissions;
        break;

      // The Diet Question
      case 2:
        if (response.contains("vegetarian")) {
          // 27.5% less than default (omnivore)
          dietEmissions = avgCarbonFootprint * (12.5 * 0.725 / 100);
        }

        else if (response.contains("vegan")) {
          // 35% less than default (omnivore)
          dietEmissions = avgCarbonFootprint * (12.5 * 0.65 / 100);
        }

        else if (response.contains("pescatarian")) {
          // 20% less than default (omnivore)
          dietEmissions = avgCarbonFootprint * (12.5 * 0.80 / 100);
        }

        else {
          /*
           * Diet takes about 25% of avg carbon footprint, but we split it across body type and diet
           * This is because body type can affect diet-related emissions
           */
          dietEmissions = avgCarbonFootprint * 0.125;
        }

        userEmissions += dietEmissions;
        break;

      // The Heating Question
      case 4:
        if (response.contains("wood")) {
          // 15% more than default (natural gas)
          heatingEmissions = avgCarbonFootprint * (20 * 1.15 / 100);
        }

        else if (response.contains("coal")) {
          // 75% more than default (natural gas)
          heatingEmissions = avgCarbonFootprint * (20 * 1.75 / 100);
        }

        else if (response.contains("electricity")) {
          // 20% less than default (natural gas)
          heatingEmissions = avgCarbonFootprint * (20 * 0.8 / 100);
        }

        else {
          // Heating by natural gas accounts for about 20% of avg carbon footprint
          heatingEmissions = avgCarbonFootprint * 0.2;
        }

        userEmissions += heatingEmissions;
        break;

      // The Transport Mode Question
      case 5:
        if (response.contains("public")) {
          // 50% less than default (private)
          transportModeEmissions = avgCarbonFootprint * (12.5 * 0.5 / 100);
        }

        else if (response.contains("walk/bicycle")) {
          // 95% less than default (private)
          transportModeEmissions = avgCarbonFootprint * (12.5 * 0.05 / 100);
        }

        else {
          /*
           * Petrol cars account for about 25% of avg carbon footprint
           * Like the diet/body type split, we split this 25% across transport mode and vehicle type
           * This is because transport mode and vehicle type are very much connected
           */
          transportModeEmissions = avgCarbonFootprint * 0.125;
        }
        userEmissions += transportModeEmissions;
        break;

      // The Vehicle Type Question
      case 6:
        if (transportModeEmissions == avgCarbonFootprint * (15 * 0.05 / 100)) {
          // Almost no vehicle emissions if walking/bicycling
          vehicleTypeEmissions = transportModeEmissions;
        }

        else if (response.contains("diesel")) {
          // 10% less than default (petrol)
          vehicleTypeEmissions = avgCarbonFootprint * (12.5 * 0.9 / 100);
        }

        else if (response.contains("hybrid")) {
          // 30% less than default (petrol)
          vehicleTypeEmissions = avgCarbonFootprint * (12.5 * 0.7 / 100);
        }

        else if (response.contains("lpg")) {
          // 15% less than default (petrol)
          vehicleTypeEmissions = avgCarbonFootprint * (12.5 * 0.85 / 100);
        }

        else if (response.contains("electric")) {
          // 55% less than default (petrol)
          vehicleTypeEmissions = avgCarbonFootprint * (12.5 * 0.45 / 100);
        }

        else {
          /*
           * Petrol cars account for about 25% of avg carbon footprint
           * Like the diet/body type split, we split this 25% across transport mode and vehicle type
           * This is because transport mode and vehicle type are very much connected
           */
          vehicleTypeEmissions = avgCarbonFootprint * 0.125;
        }

        userEmissions += vehicleTypeEmissions;
        break;

      // The Social Activity Question
      case 7:
        if (response.contains("often")) {
          // 10% more than default (sometimes)
          socialEmissions = avgCarbonFootprint * (7 * 1.1 / 100);
        }

        else if (response.contains("never")) {
          // 10% less than default (sometimes)
          socialEmissions = avgCarbonFootprint * (7 * 0.9 / 100);
        }

        else {
          // Being sometimes socially active contributes to 7% of avg carbon footprint
          socialEmissions = avgCarbonFootprint * 0.07;
        }
        userEmissions += socialEmissions;
        break;

      // The Air Travel Question
      case 9:
        if (response.contains("frequently")) {
          // 300% more than default (rarely)
          airTravelEmissions = avgCarbonFootprint * (2.5 * 4 / 100);
        }

        else if (response.contains("never")) {
          // 100% less than default (rarely)
          airTravelEmissions = 0;
        }

        else if (response.contains("very frequently")) {
          // 500% more than default (rarely)
          airTravelEmissions = avgCarbonFootprint * (2.5 * 6 / 100);
        }

        else {
          // Air travel accounts for about 2.5% of avg carbon footprint
          airTravelEmissions = avgCarbonFootprint * 0.025;
        }
        userEmissions += airTravelEmissions;
        break;

      // The Waste Bag Size Question
      case 11:
        if (response.contains("extra large")) {
          // 50% more than default (medium)
          wasteBagEmissions = avgCarbonFootprint * (3 * 1.5 / 100);
        }

        else if (response.contains("large")) {
          // 30% more than default (medium)
          wasteBagEmissions = avgCarbonFootprint * (3 * 1.3 / 100);
        }

        else if (response.contains("small")) {
          // 15% less than default (medium)
          wasteBagEmissions = avgCarbonFootprint * (3 * 0.85 / 100);
        }

        else {
          // Medium waste bags account for about 3% of avg carbon footprint
          wasteBagEmissions = avgCarbonFootprint * 0.03;
        }
        userEmissions += wasteBagEmissions;
        break;

      // The Energy Efficient Devices Question
      case 16:

        if (response.contains("Yes")) {
          // 20% less than default (sometimes)
          energyEfficientDevicesEmissions = avgCarbonFootprint * (5 * 0.8 / 100);
        }

        else if (response.contains("No")) {
          // 20% more than default (sometimes)
          energyEfficientDevicesEmissions = avgCarbonFootprint * (5 * 1.20 / 100);
        }

        else {
          // Sometimes using energy efficient devices accounts for about 5% of avg carbon footprint
          energyEfficientDevicesEmissions = avgCarbonFootprint * 0.05;
        }

        userEmissions += energyEfficientDevicesEmissions;
        break;

      // The Cooking Device Question
      case 18:
        if (response.contains("Microwave") || response.contains("Airfryer")) {
          // 40% less than default (stove)
          cookingEmissions = avgCarbonFootprint * (3 * 0.6 / 100);
        }

        else if (response.contains("Grill") || response.contains("Oven")) {
          cookingEmissions = avgCarbonFootprint * (3 * 1.2 / 100);
        }

        else {
          // Using a stove accounts for about 3% of avg carbon footprint
          cookingEmissions = avgCarbonFootprint * 0.03;
        }
        userEmissions += cookingEmissions;
        break;

      // I skipped all non-SINGLECHOICE questions for now, too complicated to calculate
      default:
        continue;
    }
  }

  // Calculating other emissions not accounted for
  otherEmissions = userEmissions -
      (bodyTypeEmissions + dietEmissions + heatingEmissions
          + transportModeEmissions + vehicleTypeEmissions + socialEmissions
          + airTravelEmissions + wasteBagEmissions + energyEfficientDevicesEmissions
          + cookingEmissions);

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
                  // Placeholder percentile calculation
                  "${100 - (userEmissions / 1000 / 20 * 100).round()}th",
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

          SizedBox(height: 10), // Space between title and pie chart

          SizedBox(
            height: 425,
            width: 100,
            child: PieChart( // Pie chart showing carbon footprint breakdown
              PieChartData(
                pieTouchData: PieTouchData( // Makes pie chart sections touchable),
                  touchCallback: (event, response) {

                  },
                ),
                sections: [ // Pie chart sections

                  // Body Type Section
                  PieChartSectionData(
                    value: (bodyTypeEmissions / userEmissions * 100), // Values per section should add up to 100
                    color: Colors.green,
                    title: 'Body\nType',
                    radius: 182, // Used to adjust size (make sure all sections have the same radius)
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.15, // Adjusts position of title within section
                  ),

                  // Diet Section
                  PieChartSectionData(
                    value: (dietEmissions / userEmissions * 100),
                    color: Colors.blue,
                    title: 'Diet',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.1
                  ),

                  // Heating Section
                  PieChartSectionData(
                    value: (heatingEmissions / userEmissions * 100),
                    color: Colors.deepOrange,
                    title: 'Heating',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.2
                  ),

                  // Transport Mode Section
                  PieChartSectionData(
                    value: (transportModeEmissions / userEmissions * 100),
                    color: Colors.purple,
                    title: 'Transport',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 0.7
                  ),

                  // Vehicle Type Section
                  PieChartSectionData(
                    value: (vehicleTypeEmissions / userEmissions * 100),
                    color: Colors.pinkAccent,
                    title: 'Vehicle Type',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.175
                  ),

                  // Social Activity Section
                  PieChartSectionData(
                    value: (socialEmissions / userEmissions * 100),
                    color: Colors.red,
                    title: 'Social',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.1
                  ),

                  // Air Travel Section
                  PieChartSectionData(
                    value: (airTravelEmissions / userEmissions * 100),
                    color: Colors.cyan,
                    title: 'Air\nTravel',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.2
                  ),

                  // Waste Bag Size Section
                  PieChartSectionData(
                    value: (wasteBagEmissions / userEmissions * 100),
                    color: Colors.indigoAccent,
                    title: 'Waste',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 1.15
                  ),

                  // Energy Efficient Devices Section
                  PieChartSectionData(
                    value: (energyEfficientDevicesEmissions / userEmissions * 100),
                    color: Colors.lime,
                    title: 'Devices',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 0.8
                  ),

                  // Cooking Device Section
                  PieChartSectionData(
                    value: (cookingEmissions / userEmissions * 100),
                    color: Colors.blueGrey,
                    title: 'Cooking',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    titlePositionPercentageOffset: 0.8
                  ),

                  // Other Section
                  PieChartSectionData(
                    value: (otherEmissions / userEmissions * 100),
                    color: Colors.blueGrey,
                    title: 'Other',
                    radius: 182,
                    titleStyle: GoogleFonts.getFont(
                      "Rubik",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                sectionsSpace: 7.5, // Determines gap between one section and another (0 means the different colors touch)
                centerSpaceRadius: 0 // Determines if the pie chart has a hole (0 means no hole)
              ),
            ),
          ),

          SizedBox(height: 20), // Space between pie chart and bar chart title

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
                                toY: (userEmissions / 1000).roundToDouble(),
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