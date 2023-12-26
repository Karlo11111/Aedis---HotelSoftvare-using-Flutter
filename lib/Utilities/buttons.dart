// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.buttonText,
      required this.ontap,
      required this.height,
      required this.width
      });

  final Function()? ontap;
  final String buttonText;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.blue.shade900,
        ),
        alignment: Alignment.center,
        height: height,
        width: width,
        child: Text(
          buttonText,
          style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.background,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
