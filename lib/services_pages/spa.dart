// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables

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
                      Text("Spa",
                          style: GoogleFonts.inter(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //opis usluge
                  Text(
                    'Escape to the tranquility of a hotel Spa:',
                    style: GoogleFonts.inter(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Relax and rejuvenate in our saunas and steam rooms, where the soothing warmth melts away stress and leaves you feeling revitalized. Our expert therapists offer invigorating body scrubs and wraps using natural ingredients to cleanse and refresh your skin, ensuring a radiant glow.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'For those in search of inner peace, our meditation and relaxation room provides a serene retreat. Our hydrotherapy options, including whirlpools and thermal baths, offer the perfect way to unwind and soothe your body.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Indulge in our beauty and skincare treatments, customized to suit your needs. Enjoy personalized facials, and manicures and pedicures that will leave you looking and feeling your best. Our spa experience goes beyond massages, focusing on your holistic well-being.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Escape the everyday and experience the ultimate in self-care and relaxation at our exclusive hotel spa.',
                    style: GoogleFonts.inter(fontSize: 16.0),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  MyButton(
                    buttonText: "Book Now",
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
