// ignore_for_file: prefer_const_constructors
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                        AppLocalizations.of(context)!.lunch,
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.lunch_1,
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.lunch_2,
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.lunch_3,
                    style: GoogleFonts.inter(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.lunch_4,
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
