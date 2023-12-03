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
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(isDarkMode
                    ? 'lib/assets/darkBackground.jpg'
                    : 'lib/assets/lightBackground.jpg'),
                fit: BoxFit.cover)),
        child: Center(
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
                        Text(AppLocalizations.of(context)!.sign_in,
                            style: GoogleFonts.inter(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary)),
                      ],
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.sign_in_text,
                          style: GoogleFonts.inter(
                              fontSize: 17.4,
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

                    //Rem me&forgot passwd - jos treba funkcionalnost
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                            direction: Axis.horizontal,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            spacing: -5,
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
                                AppLocalizations.of(context)!.remember_me,
                                style: GoogleFonts.inter(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.w300),
                              )
                            ]),
                        GestureDetector(
                          child: Text(
                            AppLocalizations.of(context)!.forgot_your_password,
                            style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPasswd(),
                              ),
                            );
                          },
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    //login button
                    MyButton(
                      buttonText: AppLocalizations.of(context)!.sign_in,
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
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppLocalizations.of(context)!.or_continiue_with,
                          style: GoogleFonts.inter(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          width: 10,
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
                              AppLocalizations.of(context)!.register_now,
                              style: GoogleFonts.inter(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
    );
  }
}
