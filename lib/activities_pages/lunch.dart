// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Lunch extends StatelessWidget {
  const Lunch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(isDarkMode
                    ? 'lib/assets/darkBackground.jpg'
                    : 'lib/assets/lightBackground.jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      "lib/assets/Lunch.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Text(
                        'Hotel Lunch',
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Experience an extended hotel lunch from 12:00 PM to 2:00 PM, creating a two-hour oasis of culinary delight in your day.",
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Our diverse lunch menu includes international and local cuisines, ensuring a delectable journey. Choose from refreshing salads, succulent meats, or wholesome vegetarian options.",
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Enhance your dining experience with the soothing melodies of live music, complemented by our attentive staff's impeccable service, whether you're here for business or leisure.",
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "As the clock nears 2:00 PM, our dessert selection shines with an array of sweet treats, from rich cakes to delicate pastries and fresh fruits. Mark a special occasion or take a break from your daily routine; our extended hotel lunch promises to make lasting memories.",
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
