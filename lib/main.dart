import 'package:carbon_footprint/Pages/chat_page.dart';
import 'package:carbon_footprint/Pages/widget_tree.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
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
    initConversation();
    return MaterialApp(
      title: 'Flutter Demo',
      home: WidgetTree(),
      debugShowCheckedModeBanner: false,
    );
  }
}