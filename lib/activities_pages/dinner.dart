// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Dinner extends StatelessWidget {
  const Dinner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "lib/assets/Dinner.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Text(
                      'Hotel Dinner',
                      style: GoogleFonts.inter(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Hotel dinners are a blend of luxury and culinary excellence. Whether you seek fine dining or a casual meal, hotels have you covered.',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Enjoy the convenience of room service after a long day of travel, and experience impeccable service from welcoming staff and attentive servers.',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'Hotel chefs create diverse menus, blending local and international flavors. Your dining experience is enhanced with carefully curated wine lists.',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
                SizedBox(height: 16),
                Text(
                  'In summary, hotel dinners offer convenience, top-notch service, and culinary excellence, ensuring a memorable dining experience for all guests.',
                  style: GoogleFonts.inter(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
