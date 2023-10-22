// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
        child: CircularProgressIndicator(),),
    );

    //make sure the passwords match
    if(passwordTextController.text != confirmPasswordTextController.text){
      //pop loading circle
      Navigator.pop(context);
      //display an error message
      displayMessage("Passwords don't match");
      return;
    }
    

    //try creating the user 
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text, 
        password: passwordTextController.text
      );
      //add to database
      addUserDetails(emailTextController.text, nameTextController.text);
      //pop loading circle
      if(context.mounted) Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      //pop loading circle
      Navigator.pop(context);

      //display error to user 
      displayMessage(e.code);

    }
  }

  //add users data to the firebase firestore
  Future addUserDetails (String UserEmail, String Name,) async {
      await FirebaseFirestore.instance.collection("User Email").add(
        {
          'UserEmail': UserEmail,
          'Name': Name,
        }
      );
    }
  
  //displaying message for errors
  void displayMessage(String message){
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
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  //LOGO
                  const Icon(Icons.lock, size: 100,),
                  
                  //SIZED BOX
                  const SizedBox(height: 50),
        
                  //TEXT
                  const Text("Lets create an account for you", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          
                  //SIZED BOX
                  const SizedBox(height: 15),
        
                  //TEXTFIELDS FOR EMAIL AND PASSWORD

                  //name text field
                  MyTextField(
                    controller: nameTextController, 
                    hintText: "Enter your name", 
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  //email
                  MyTextField(
                    controller: emailTextController, 
                    hintText: "Enter your email", 
                    obscureText: false,
                  ),
                  const SizedBox(height: 10),
                  //password
                  MyTextField(
                    controller: passwordTextController,
                    hintText: "Enter your password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  //password
                  MyTextField(
                    controller: confirmPasswordTextController,
                    hintText: "Confirm your password",
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  //LOG IN BUTTON
                  MyButton(
                    buttonText: "SIGN UP",
                    ontap: signUp,
                  ),
                  //SIZED BOX
                  const SizedBox(height: 15),
                  
                  //TEXT WITH REGISTER PAGE TEXT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already a member?"),
                      const SizedBox(width: 5,),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text("Sign In Now!", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                      ),
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