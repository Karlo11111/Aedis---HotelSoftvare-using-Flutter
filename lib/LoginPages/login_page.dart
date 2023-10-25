// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.ontap}) : super(key: key);
  final Function()? ontap;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers for text
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  // Sign-in function
  void signIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    // Try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);
      // Display an error message while logging in
      displayMessage(e.code);
    }
  }

  // Display a message with the error
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message),
        ),
      ),
    );
  }

  // The main frontend code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 1000,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.orange.shade800,
              Colors.orange.shade600,
              Colors.orange.shade200,
            ],
          )),
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Icon(Icons.lock_clock, size: 90, color: Colors.blue),

                    // SizedBox
                    SizedBox(height: 50),

                    // Text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start, // Align "Login" text to the left
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .6,
                            height: 1.2,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Please sign in to continiue.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: .6,
                            height: 1.2,
                            decoration: TextDecoration.none,
                            color: Colors.grey[700],
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),

                    // SizedBox
                    SizedBox(height: 15),

                    // TextFields for email and password
                    // Email
                    MyTextField(
                      controller: emailTextController,
                      hintText: "Email",
                      obscureText: false,
                    ),

                    // SizedBox
                    const SizedBox(height: 20),

                    // Password
                    MyTextField(
                      controller: passwordTextController,
                      hintText: "Password",
                      obscureText: true,
                    ),

                    // SizedBox
                    const SizedBox(height: 10),

                    // Login button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton(
                          buttonText: "Login",
                          ontap: signIn,
                        ),
                      ],
                    ),

                    // SizedBox
                    const SizedBox(height: 10),

                    // Text with register page text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 250),
                        const Text("Not a member?"),
                        const SizedBox(
                          width: 5,
                          height: 100,
                        ),
                        GestureDetector(
                          onTap: widget.ontap,
                          child: const Text(
                            "Register Now!",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
