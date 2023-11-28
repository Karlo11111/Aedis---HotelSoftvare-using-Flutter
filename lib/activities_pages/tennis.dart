// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tennis extends StatelessWidget {
  const Tennis({Key? key}) : super(key: key);

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
                      "lib/assets/Tennis.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Text(
                        'Hotel Tennis',
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tennis enthusiasts will find plenty of reasons to smile when staying at our hotel. We offer a fantastic on-site tennis facility that caters to players of all skill levels. Whether you\'re a seasoned pro or a novice looking to improve your game, our well-maintained courts and professional coaching staff are here to ensure a memorable tennis experience.',
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Our hotel\'s tennis facility features multiple hard and clay courts, providing options for different playing styles. The courts are well-lit, allowing for evening matches, and we offer equipment rentals for those who don\'t have their gear with them. Enjoy a game with friends or engage in a friendly tournament with fellow guests, creating lasting memories during your stay.',
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'For those seeking professional instruction, we offer tennis lessons led by certified coaches. Whether you\'re looking to refine your technique, learn the basics, or simply enjoy a fun, active vacation, our tennis program has something for everyone. It\'s the perfect opportunity to unwind and enjoy some competitive action while staying at our hotel.',
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'After a challenging game or a stimulating lesson, take advantage of our hotel\'s amenities, such as a relaxing spa, fine dining, and comfortable accommodations. With tennis available on-site, you can make the most of your stay by combining luxury and sport, ensuring a well-rounded and memorable experience for all guests.',
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
