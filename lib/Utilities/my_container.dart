// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.child,
      required this.decorationColor});

  final double width;
  final double height;
  final Widget child;
  final Color decorationColor;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: decorationColor,
        borderRadius: BorderRadius.circular(30),
        //box shadow
        boxShadow: [
          BoxShadow(
            color:
                isDarkMode ? Color.fromARGB(200, 7, 7, 7) : Colors.grey[300]!,
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: child,
    );
  }
}
