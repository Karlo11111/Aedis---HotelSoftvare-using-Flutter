// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/LoginPages/login_page.dart';
import 'package:razvoj_sofvera/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(
        ontap: () {
          
        },
      ),
    );
  }
}
