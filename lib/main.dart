import 'package:agrozon/AppConstants/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:agrozon/Pages/LandingPage.dart';

void main() {
  runApp(MaterialApp(
    home: LandingPage(),
    theme: ThemeData(
        primaryColor: AppColors.greenColor,
      ),
  ));
}
