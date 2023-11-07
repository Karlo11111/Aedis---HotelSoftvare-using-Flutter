// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Introduction_screens/onBoardingScreen.dart';
import 'package:razvoj_sofvera/authentification/auth.dart';

class FirstAuthPage extends StatelessWidget {
  const FirstAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //user is logged in
        if (snapshot.hasData) {
          return const AuthPage();
        } else {
          return const OnBoardingScreen();
        }
      },
    ));
  }
}