import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_ml_example/utils/constants.dart';
import 'package:google_ml_example/view/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: mainColor,
      ),
      home: LandingScreen(),
    );
  }
}
