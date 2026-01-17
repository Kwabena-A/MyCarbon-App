import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Pages/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  Question.initConversation(); // adds first chat message
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode
        .immersiveSticky, // Hides nav and status bars, but allows swipe to show temporarily
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home:
          WidgetTree(), // Main parent widget. Switches between home, chat and statistic page.
      debugShowCheckedModeBanner: false,
    );
  }
}