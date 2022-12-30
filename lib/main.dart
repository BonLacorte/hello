import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/controller/auth_controller.dart';
import 'package:news_app/responsive/responsive_layout_screen.dart';
import 'package:news_app/responsive/web_screen_layout.dart';
import 'package:news_app/screens/auth/login_screen.dart';
import 'package:news_app/screens/auth/signup_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/sample_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News News News',
      theme: ThemeData.light(),
      home: ResponsiveLayoutScreen(
        mobileScreenLayout: LoginScreen(),
        webScreenLayout: WebScreenLayout(),
      ),
      //home: SampleScreen(),
    );
  }
}
