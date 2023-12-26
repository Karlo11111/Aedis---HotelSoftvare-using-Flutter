// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables, avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:razvoj_sofvera/LoginPages/forgot_passwd.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(""), fit: BoxFit.cover)),
        child: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    //box shadow
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 196, 195, 195),
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
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //SIZED BOX
                        SizedBox(height: 30),

                        //SIGN IN TEXT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(AppLocalizations.of(context)!.sign_in,
                                style: GoogleFonts.inter(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                          ],
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        //SIGN IN OR UP TO USE OUR APPLICATION TEXT
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.sign_in_text,
                              style: GoogleFonts.inter(
                                  fontSize: 13.4,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).colorScheme.primary),
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
                          hintText: AppLocalizations.of(context)!.password,
                          obscureText: true,
                        ),

                        //sized box
                        const SizedBox(height: 20),

                        const SizedBox(
                          height: 20,
                        ),

                        //login button
                        MyButton(
                          buttonText: AppLocalizations.of(context)!.sign_in,
                          ontap: SignIn,
                          height: 50,
                          width: 150,
                        ),

                        //sized box
                        const SizedBox(height: 10),
                        //sign in with google
                        TextButton(
                          child: Container(
                            height: 50,
                            width: 150,
                            child: FaIcon(FontAwesomeIcons.google),
                          ),
                          onPressed: signInWithGoogle,
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
                                  AppLocalizations.of(context)!.register_now,
                                  style: GoogleFonts.inter(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
