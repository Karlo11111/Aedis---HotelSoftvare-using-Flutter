// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/services_pages/BookNow/book_now_spa.dart';

class Spa extends StatelessWidget {
  const Spa({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      //Body

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
                  //slika usluge
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      "lib/assets/spa.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),

                  //razmak između slike i usluge
                  const SizedBox(height: 36),

                  //naziv usluge
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.spa,
                          style: GoogleFonts.inter(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //opis usluge
                  Text(
                    AppLocalizations.of(context)!.spa_1,
                    style: GoogleFonts.inter(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.spa_2,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.spa_3,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.spa_4,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    AppLocalizations.of(context)!.spa_5,
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  MyButton(
                    buttonText: AppLocalizations.of(context)!.book_now,
                    height: 60,
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => BookSpa()));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
