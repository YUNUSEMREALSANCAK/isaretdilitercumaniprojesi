import 'package:flutter/material.dart';
import 'dart:ui';

class CustomTheme {
  const CustomTheme();

  static const Color colorPage1 = Color(0xFFB3E5FC);
  static const Color colorPage2 = Color(0xFFFFCCBC);
  static const Color colorPage3 = Color(0xFFC8E6C9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[colorPage1, colorPage2],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}


class Images {

  const Images();
  static const String images1=  'assets/images/image-1.png';
  static const String images2=  'assets/images/image-2.png';
  static const String images3=  'assets/images/image-3.png';
  static const String images4=  'assets/images/image-4.png';
  static const String images5=  'assets/images/image-5.png';

}