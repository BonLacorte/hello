import 'package:flutter/material.dart';
import 'package:news_app/responsive/responsive_layout_screen.dart';
import 'package:news_app/responsive/web_screen_layout.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/sample_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News News News',
      theme: ThemeData.light(),
      home: ResponsiveLayoutScreen(
        mobileScreenLayout: SampleScreen(),
        webScreenLayout: WebScreenLayout(),
      ),
      //home: SampleScreen(),
    );
  }
}
