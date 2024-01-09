// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoContainer extends StatelessWidget {
  final String imagePath;
  final String title;
  final String content;
  final Widget? row;
  final Widget? rating;

  const InfoContainer({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.content,
    this.row,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      width: MediaQuery.of(context).size.width - 80.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 196, 195, 195),
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            child: Image.asset(
              imagePath,
              width: MediaQuery.of(context).size.width - 60.0,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.0),
                rating ?? Container(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0, left: 16.0, bottom: 14),
            child: Text(
              content,
              style: GoogleFonts.inter(fontSize: 10.0),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 16, top: 8, right: 12),
              child: row ?? Container()),
        ],
      ),
    );
  }
}
