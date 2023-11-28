// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Breakfast extends StatelessWidget {
  const Breakfast({Key? key}) : super(key: key);

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
                      "lib/assets/Breakfast.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Text(
                        'Hotel Breakfast',
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Enjoy a diverse breakfast selection from 7:00 AM to 10:00 AM.',
                    style: GoogleFonts.inter(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Choose from pastries, eggs, bacon, fresh fruits, and more in a welcoming atmosphere.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Our attentive staff ensures a great dining experience.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Flexible breakfast hours for your convenience.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Start your day with a hearty meal that caters to all tastes, setting the perfect tone for your stay.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
