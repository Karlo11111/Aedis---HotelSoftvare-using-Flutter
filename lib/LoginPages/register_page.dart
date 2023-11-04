// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final user = FirebaseAuth.instance.currentUser;
  //text controllers for register page text fields
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  //sign users up
  void signUp() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //make sure the passwords match
    if (passwordTextController.text != confirmPasswordTextController.text) {
      Navigator.pop(context);
      //display an error message
      displayMessage("Passwords don't match");
      return;
    }
    //try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      //add to database
      addUserDetails(emailTextController.text, nameTextController.text);
      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //display error to user
      displayMessage(e.code);
    }
  }

  //adding user details when logging in and setting it to a specific user uid
  Future addUserDetails(
    String UserEmail,
    String Name,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("User Email")
        .doc(user!.uid)
        .set({
      'UserEmail': UserEmail,
      'Name': Name,
    });
  }

  //displaying message for errors
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SIZED BOX
                  const SizedBox(height: 50),

                  //TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Make an \naccount ",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ],
                  ),

                  //SIZED BOX
                  const SizedBox(height: 15),

                  //TEXTFIELDS FOR EMAIL AND PASSWORD

                  //name text field
                  MyTextField(
                    controller: nameTextController,
                    hintText: "Name",
                    obscureText: false,
                  ),
                  const SizedBox(height: 18),
                  //email
                  MyTextField(
                    controller: emailTextController,
                    hintText: "Email",
                    obscureText: false,
                  ),
                  const SizedBox(height: 18),
                  //password
                  MyTextField(
                    controller: passwordTextController,
                    hintText: "Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 18),
                  //password
                  MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: "Confirm Password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 18),
                  //LOG IN BUTTON
                  MyButton(
                    buttonText: "SIGN UP",
                    ontap: signUp,
                    height: 65,
                  ),
                  //SIZED BOX
                  const SizedBox(height: 15),

                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      )),
                      Text(
                        'Or continue with',
                        style: GoogleFonts.inter(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                      )
                    ],
                  ),

                  //google, facebook, apple login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 40,
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.google)),
                      SizedBox(width: 10),
                      IconButton(
                          iconSize: 40,
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.facebook)),
                      SizedBox(width: 10),
                      IconButton(
                          iconSize: 47,
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.apple)),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //TEXT WITH REGISTER PAGE TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already a member?",
                        style: GoogleFonts.inter(color: Colors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: widget.onTap,
                          child: Text(
                            "Sign In Now!",
                            style: GoogleFonts.inter(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
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
