// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:razvoj_sofvera/Utilities/edit_item.dart';

class EditAccountScreen extends StatefulWidget {
  const EditAccountScreen({super.key, required this.refreshSettingsPage});

  final Function refreshSettingsPage;

  @override
  State<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends State<EditAccountScreen> {
  final changedNameTextController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appbar for saving and exiting
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        leading: IconButton(
          color: Colors.black,
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
              style: IconButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                fixedSize: Size(70, 55),
              ),
              icon: Icon(
                Ionicons.checkmark,
                color: Colors.green,
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Account",
                style: GoogleFonts.inter(
                    fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),

              //photo

              EditItem(
                  title: "Photo",
                  widget: Column(
                    children: [
                      Image.asset(
                        "lib/assets/avatar.png",
                        height: 100,
                        width: 100,
                      ),
                      TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.lightBlueAccent,
                          ),
                          child: const Text("Upload Image"))
                    ],
                  )),

              //
              EditItem(
                title: "Name",
                widget: TextField(
                  controller: changedNameTextController,
                ),
              ),

              //user gender

              const SizedBox(
                height: 20,
              ),

              EditItem(
                title: "Gender",
                widget: Row(
                  children: [
                    //male icon
                    CircleAvatar(
                      radius: 25,
                      backgroundColor:
                          gender == "man" ? Colors.blue : Colors.grey.shade200,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              gender = "man";
                            });
                          },
                          icon: Icon(
                            color:
                                gender == "man" ? Colors.white : Colors.black,
                            Ionicons.male,
                            size: 18,
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),

                    //woman icon
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: gender == "woman"
                          ? Colors.purpleAccent
                          : Colors.grey.shade200,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              gender = "woman";
                            });
                          },
                          icon: Icon(
                            color:
                                gender == "woman" ? Colors.white : Colors.black,
                            Ionicons.female,
                            size: 18,
                          )),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //age

              EditItem(widget: TextField(), title: "Age"),

              const SizedBox(
                height: 20,
              ),

              //Email
              EditItem(title: "Email", widget: TextField()),
            ],
          ),
        ),
      ),
    );
  }
}
