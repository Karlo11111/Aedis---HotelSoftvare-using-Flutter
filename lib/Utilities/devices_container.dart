// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDeviceContainer extends StatelessWidget {
  const MyDeviceContainer({
    super.key,
    required this.color,
    required this.text,
    required this.image,
  });

  final Color color;
  final String text;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          image,
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              text,
              style:
                  GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
