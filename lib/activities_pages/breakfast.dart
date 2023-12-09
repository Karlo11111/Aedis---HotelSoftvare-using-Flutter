// ignore_for_file: prefer_const_constructors
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class Breakfast extends StatelessWidget {
  const Breakfast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
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
                        AppLocalizations.of(context)!.breakfast,
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.breakfast_1,
                    style: GoogleFonts.inter(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.breakfast_2,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.breakfast_3,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.breakfast_4,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.breakfast_5,
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
