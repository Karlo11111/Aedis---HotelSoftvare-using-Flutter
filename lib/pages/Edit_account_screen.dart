// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/edit_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';

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

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
        //appbar for saving and exiting
        appBar: AppBar(
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
                      labelText: "Username",
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
                      labelText: "Email",
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
                ],
              ),
            ),
          )),
        ));
  }
}
