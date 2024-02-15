// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:razvoj_sofvera/BottomNavBar/bottom_nav_bar.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razvoj_sofvera/pages/employee_pages/employee_main_page.dart';

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
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PagesPage(),
          ));

      // Use the user object for further operations or navigate to a new screen.
    } catch (e) {
      print(e.toString());
    }
  }

  //controllers for text
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sing in function
  void SignIn() async {
    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    // Try signing in
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailTextController.text,
              password: passwordTextController.text);

      // Check if the user is an employee
      FirebaseFirestore.instance
          .collection('Employees')
          .doc(userCredential.user!.email)
          .get()
          .then((doc) {
        if (doc.exists) {
          // User is an employee, navigate to employee page
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const EmployeePage(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          // User is a regular guest
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PagesPage(),
              ));
        }
      });
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);
      // Display if there's an error while logging in
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
        decoration: const BoxDecoration(
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
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    //box shadow
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 153, 151, 151),
                        offset: Offset(
                          2.0,
                          2.0,
                        ),
                        blurRadius: 5.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        const SizedBox(height: 40),

                        //TEXTFIELDS FOR EMAIL AND PASSWD
                        //email
                        MyTextField(
                          controller: emailTextController,
                          hintText: "Email",
                          obscureText: false,
                        ),

                        //sized box
                        const SizedBox(height: 30),

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
                          width: 200,
                          decorationColor: Colors.blue.shade900,
                          borderColor: Colors.transparent,
                          textColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),

                        //sized box
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

                        const SizedBox(
                          height: 30,
                        ),
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
