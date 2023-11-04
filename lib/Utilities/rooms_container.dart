// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRoomContainer extends StatelessWidget {
  const MyRoomContainer({super.key, required this.name, required this.icon});

  final String name;
  final FaIcon icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          color: Color.fromARGB(255, 197, 197, 196),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 118, 144, 175)),
        ),
      ],
    );
  }
}
