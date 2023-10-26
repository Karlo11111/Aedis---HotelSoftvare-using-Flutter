// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    var rememberMe;
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
                      Text("Sign in", style: TextStyle(fontSize: 40)),
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
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  //SIZED BOX
                  SizedBox(height: 15),

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

                  //Rem me&forgot passwd
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          child: Text("Forgot your password?"), onTap: () {})
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

                  //TEXT WITH REGISTER PAGE TEXT

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a member?"),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: widget.ontap,
                          child: const Text(
                            "Register Now!",
                            style: TextStyle(
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
