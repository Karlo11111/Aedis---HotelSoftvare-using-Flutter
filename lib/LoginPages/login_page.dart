// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.ontap});
  final Function()? ontap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers for text
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  
  //sing in function
  void SignIn() async{
    //show loading circle
    showDialog(
      context: context, 
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text, 
        password: passwordTextController.text
      );
      if(context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch(e) {
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
      )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //LOGO
                  Icon(Icons.lock_clock, size: 100),
                  
                  //SIZED BOX
                  SizedBox(height: 50),
        
                  //TEXT
                  Text("Sign in to your account", style: TextStyle(fontSize: 30)),
        
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
                  const SizedBox(height: 10),
                  
                  //login button
                  MyButton(buttonText: "Sign in", ontap: SignIn)
        
                  //text with register page button text
                ],
                  
              ),
            ),
          ),
        ),
      ),



    );
  }
}