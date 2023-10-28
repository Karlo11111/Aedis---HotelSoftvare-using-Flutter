// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.ontap,
  });
  final Function()? ontap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  //bool for checkbox
  bool _isChecked = false;

  //controllers for text
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sing in function
  void SignIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    //try signing in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);
      //display if theres and error while logging in
      displayMessage(e.code);
    }
  }

  //dispaly a message with the error
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

  //the main frontend code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //SIZED BOX
                  SizedBox(height: 50),

                  //TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Sign in",
                          style: GoogleFonts.inter(
                              fontSize: 35, fontWeight: FontWeight.w600)),
                    ],
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Please sing in to use our platform",
                        style: GoogleFonts.inter(
                            fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),

                  //SIZED BOX
                  SizedBox(height: 30),

                  //TEXTFIELDS FOR EMAIL AND PASSWD
                  //email
                  MyTextField(
                    controller: emailTextController,
                    hintText: "Email",
                    obscureText: false,
                  ),

                  //sized box
                  const SizedBox(height: 20),

                  //passwd
                  MyTextField(
                    controller: passwordTextController,
                    hintText: "Password",
                    obscureText: true,
                  ),

                  //sized box
                  const SizedBox(height: 20),

                  //Rem me&forgot passwd - jos treba funkcionalnost
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: -15,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value1) {
                                setState(() {
                                  _isChecked = value1!;
                                });
                              },
                            ),
                            Text(
                              "  Remember me",
                              style: GoogleFonts.inter(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            )
                          ]),
                      GestureDetector(
                          child: Text(
                            "Forgot your password?",
                            style: GoogleFonts.inter(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {})
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //login button
                  MyButton(
                    buttonText: "Sign in",
                    ontap: SignIn,
                    height: 50,
                  ),

                  //sized box
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 0.5,
                      )),
                      Text(
                        'Or continue with',
                        style: GoogleFonts.inder(
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

                  //TEXT WITH REGISTER PAGE TEXT

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          iconSize: 40,
                          onPressed: () => signInWithGoogle(),
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

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: widget.ontap,
                          child: Text(
                            "Register Now!",
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
