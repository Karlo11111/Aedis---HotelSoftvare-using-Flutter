// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              //header text
              SizedBox(
                height: 25,
              ),

              Text(
                "Request \nthe best hotels from us.",
                style: GoogleFonts.inter(
                  fontSize: 28,
                  letterSpacing: .3,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              )

              //
            ])),
      ),
    );
  }
}
