// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: signOut,
              icon: const Icon(
                Icons.logout,
                size: 50,
              )),
          SizedBox(
            height: 60,
          ),
          Text(
            "SIGN OUT",
            style: GoogleFonts.inter(fontSize: 40, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
