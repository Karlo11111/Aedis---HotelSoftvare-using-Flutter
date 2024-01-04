// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      background: Colors.white,
      primary: Colors.black,
      secondary: Color.fromARGB(255, 48, 88, 150),
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.grey.shade800,
        primary: Colors.white,
        secondary: Colors.lightGreenAccent.shade400));
