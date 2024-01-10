// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key, required this.refreshSettingsPage});

  final Function refreshSettingsPage;

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final changedNameTextController = TextEditingController();
  final changedEmailTextController = TextEditingController();
  final changePhoneNumberTextController = TextEditingController();

  //adding user details when logging in and setting it to a specific user uid
  Future addUserDetails() async {
    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection("User Email")
        .doc(user!.uid)
        .set({
      'Name': changedNameTextController.text,
      "UserEmail": user.email,
    });
    // Pop the current page
    Navigator.of(context).pop();
    changedNameTextController.clear();
  }

  //string for defining gender
  String gender = "man";

  //hive
  final myBox = Hive.box('UserInfo');

  //email hider function
  String hideEmail(String email) {
    var parts = email.split('@');
    if (parts.length != 2) return 'Invalid email';

    var username = parts[0];
    var domain = parts[1];

    if (username.length <= 2) return 'Username too short';

    var hiddenUsername = username[0] +
        '*' * (username.length - 2) +
        username[username.length - 1];

    return hiddenUsername + '@' + domain;
  }

  bool _isEmailEditing = false;
  bool _isPhoneNumberEditing = false;
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
        //appbar for saving and exiting
        appBar: AppBar(
          elevation: 0,
          backgroundColor:
              isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
          leading: IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Ionicons.chevron_back_outline),
          ),
          leadingWidth: 80,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: addUserDetails,
                icon: Icon(
                  Ionicons.checkmark,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
          child: SafeArea(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //header

                  Text(
                    "Edit personal info",
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //username
                  TextField(
                    controller: changedNameTextController,
                    decoration: InputDecoration(
                      labelText: "First name",
                      labelStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: myBox.get('username'),
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  //email
                  SizedBox(
                    height: 20,
                  ),

                  TextField(
                    controller: changedEmailTextController,
                    decoration: InputDecoration(
                      labelText: "Last name",
                      labelStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      hintText: myBox.get('email'),
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                 

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Email',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                              )),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isEmailEditing = !_isEmailEditing;
                              });
                            },
                            child: Text('Edit',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold
                              
                            ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _isEmailEditing
                                ? TextField(
                                    controller: changedEmailTextController,
                                  )
                                : Text(
                                  hideEmail(myBox.get('email')!),
                                  style: GoogleFonts.inter(),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),


                  


                   SizedBox(
                    height: 10,
                  ),

                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  //phone number

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //phone number text and edit button

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone number',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                              )),

                          TextButton(
                           onPressed: () {
                              setState(() {
                                _isPhoneNumberEditing = !_isPhoneNumberEditing;
                              });
                            },
                            child: Text('Edit',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold
                              
                            ),
                            ),)
                        ],

                      )
                    ],
                  ),

                  Text("For notifications, reminders, and help logging in.", 
                  style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 10),),

                  SizedBox(height: 10,),


                   Row(
                        children: [
                          Expanded(
                            child: _isPhoneNumberEditing
                                ? TextField(
                                    controller: changePhoneNumberTextController,
                                  )
                                : Text(
                                  "095 819 3030",
                                  style: GoogleFonts.inter(),
                                  ),
                          ),
                        ],
                      ),
                 
                ],
              ),
            ),
          )),
        ));
  }
}
