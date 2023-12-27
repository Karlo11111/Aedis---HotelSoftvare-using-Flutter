// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  final phoneNumberController = TextEditingController();

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
    if (passwordTextController.text != confirmPasswordTextController.text || phoneNumberController.text.isEmpty || nameTextController.text.isEmpty) {
      Navigator.pop(context);
      //display an error message
      displayMessage("Passwords don't match or some fields are empty");
      return;
    }
    //try creating the user
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      //add to database
      addUserDetails(emailTextController.text, nameTextController.text,
          phoneNumberController.text);
      //pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      //display error to user
      displayMessage(e.code);
    }
  }

  //for google sign in
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Use the user object for further operations or navigate to a new screen.
    } catch (e) {
      print(e.toString());
    }
  }

  //adding user details when logging in and setting it to a specific user uid
  Future addUserDetails(
    String UserEmail,
    String Name,
    String PhoneNumber,
  ) async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("User Email")
        .doc(user!.uid)
        .set({
      'UserEmail': UserEmail,
      'Name': Name,
      'PhoneNumber': PhoneNumber,
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/assets/signInBackground.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: double.infinity,
                  height: 700,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    //box shadow
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 153, 151, 151),
                        offset: const Offset(
                          2.0,
                          2.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //SIZED BOX
                        const SizedBox(height: 20),

                        //TEXT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Register now",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),

                        //SIZED BOX
                        const SizedBox(height: 10),

                        //TEXT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Register to use our platform.",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.normal, fontSize: 15),
                            ),
                          ],
                        ),

                        //SIZED BOX
                        const SizedBox(height: 15),

                        //TEXTFIELDS FOR EMAIL AND PASSWORD

                        //name text field
                        MyTextField(                        
                          controller: nameTextController,
                          hintText: "First and Last name",
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
                        MyTextField(
                          controller: phoneNumberController,
                          hintText: "Phone number",
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
                          buttonText: "Sign up",
                          ontap: signUp,
                          height: 50,
                          width: 200,
                          decorationColor: Colors.blue.shade900,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),

                        //SIZED BOX
                        const SizedBox(height: 10),

                        //sign in with google
                        MyButton(
                            buttonText: "Sign in with Google",
                            ontap: signInWithGoogle,
                            height: 50,
                            width: 200,
                            decorationColor: Colors.white,
                            borderColor: Colors.black,
                            textColor: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            icon: Image.network(
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover)),

                        //SIZED BOX
                        const SizedBox(
                          height: 25,
                        ),

                        //TEXT WITH REGISTER PAGE TEXT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already a member?",
                              style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                                onTap: widget.onTap,
                                child: Text(
                                  "Sign In Now!",
                                  style: GoogleFonts.inter(
                                      fontSize: 13,
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
          ),
        ),
      ),
    );
  }
}
