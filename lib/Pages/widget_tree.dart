import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Pages/home_page.dart';
import 'package:carbon_footprint/Pages/statistics_page.dart';
import 'package:carbon_footprint/Widgets/Action%20Bar/action_bar.dart';
import 'package:carbon_footprint/Widgets/nav_bar.dart';
import 'package:carbon_footprint/data/constants.dart';
import 'package:carbon_footprint/data/values.dart';
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  List<Widget> pages = [
    HomePage(),
    ChatPage(),
    StatisticsPage(),
  ]; // Iterated through to switch between pages

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentPage, // Valuelistenable for current page
      builder: (context, page, child) {
        return Scaffold(
          backgroundColor: KConstants.KMainGrayColor,
          body: Stack(
            children: [
              pages.elementAt(page), // Page Cycle placed behind all other UI
              ActionBar(), // Top action bar

              Column(
                mainAxisAlignment: MainAxisAlignment
                    .end, // Align Navbar to the bottom of the screen
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: NavBarWidget(),
                  ),
                ], // Bottom Nav Bar
              ),
            ],
          ),
        );
      },
    );
  }
}