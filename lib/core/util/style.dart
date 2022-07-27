import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const primaryClr = Colors.green;
const Color darkGreyClr = Color(0xFF121212);
Color greyClr = Colors.grey[500]!;

class Themes {
  static final theme = ThemeData(
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
      color: Colors.white,
      elevation: 1,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
    ),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: darkGreyClr,
  ));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: darkGreyClr,
  ));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: darkGreyClr,
  ));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: greyClr,
  ));
}

TextStyle get bodyStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: darkGreyClr,
  ));
}

TextStyle get body2Style {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: darkGreyClr,
  ));
}
