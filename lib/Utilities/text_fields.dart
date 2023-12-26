// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        labelText: hintText,
        labelStyle: GoogleFonts.inter(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.only(left: 30, top: 20, bottom: 20)
      ),
    );
  }
}
