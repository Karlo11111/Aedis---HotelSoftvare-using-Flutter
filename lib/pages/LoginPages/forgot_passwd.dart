// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswd extends StatefulWidget {
  const ForgotPasswd({super.key});

  @override
  State<ForgotPasswd> createState() => _ForgotPasswdState();
}

class _ForgotPasswdState extends State<ForgotPasswd> {
  final formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();

  //passwd reseting function
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailControler.text.trim());

      //user feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
          'Check your inbox for password reset link',
          style: GoogleFonts.inter(fontSize: 20),
        )),
      );
      //error check
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    emailControler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Reset your password",
          style: GoogleFonts.inter(color: Colors.black),
        ),
      ),

      //Receive an email text
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Receive an email to \nreset your password",
                  style: GoogleFonts.inter(fontSize: 24),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 20,
                ),

                //email input field

                TextFormField(
                  controller: emailControler,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                ),

                const SizedBox(
                  height: 20,
                ),

                //reset passwd button

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(Icons.email_outlined),
                  label: Text(
                    "Reset Password",
                    style: GoogleFonts.inter(fontSize: 24),
                  ),
                  onPressed: resetPassword,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
