import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.black,
      secondary: Colors.blueAccent.shade400,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade800,
        primary: Colors.white,
        secondary: Colors.lightGreenAccent.shade400));
