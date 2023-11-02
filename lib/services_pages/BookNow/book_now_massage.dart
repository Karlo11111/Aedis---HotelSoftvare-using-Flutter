// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class BookMassage extends StatefulWidget {
  const BookMassage({super.key});

  @override
  State<BookMassage> createState() => _BookMassageState();
}

class _BookMassageState extends State<BookMassage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),

      //body book forme

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [],
              )),
        ),
      ),
    );
  }
}
