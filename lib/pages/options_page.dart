// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_string_escapes, unused_element, dead_code
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/forward_button.dart';
import 'package:razvoj_sofvera/Utilities/setting_item.dart';
import 'package:razvoj_sofvera/Utilities/setting_switch.dart';
import 'package:razvoj_sofvera/pages/Edit_account_screen.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  bool isDarkMode = false;
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Settings",
                  style: GoogleFonts.inder(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),

                const SizedBox(
                  height: 30,
                ),

                //Acc part

                Text(
                  "Accounnt",
                  style: GoogleFonts.inder(
                      fontSize: 30, fontWeight: FontWeight.w300),
                ),

                const SizedBox(
                  height: 25,
                ),

                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Image.asset(
                        "lib/assets/avatar.png",
                        width: 70,
                        height: 70,
                      ),
                      const SizedBox(
                        width: 20,
                      ),

                      //username&bio
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Antonio Kocijan",
                            style: GoogleFonts.inder(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Something Something",
                            style: GoogleFonts.inder(
                                fontSize: 14, color: Colors.grey),
                          )
                        ],
                      ),

                      //Acc button
                      const Spacer(),
                      ForwardButton(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditAccountScreen(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                //settings

                const SizedBox(
                  height: 40,
                ),

                Text("Settings",
                    style: GoogleFonts.inder(
                        fontSize: 30, fontWeight: FontWeight.w300)),

                const SizedBox(
                  height: 20,
                ),

                //language

                SettingItem(
                  title: "Language",
                  icon: Ionicons.earth,
                  bgColor: Colors.orange.shade100,
                  iconColor: Colors.orange,
                  value: "English",
                  onTap: () {},
                ),

                const SizedBox(
                  height: 20,
                ),

                //notifications

                SettingItem(
                  title: "Notifications",
                  icon: Ionicons.notifications,
                  bgColor: Colors.blue.shade100,
                  iconColor: Colors.blue,
                  onTap: () {},
                ),

                const SizedBox(
                  height: 20,
                ),

                //dark theme

                SettingSwitch(
                  title: "Dark Mode",
                  icon: Ionicons.moon_sharp,
                  bgColor: Colors.purple.shade100,
                  iconColor: Colors.purple,
                  value: isDarkMode,
                  onTap: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),

                const SizedBox(
                  height: 20,
                ),

                //help

                SettingItem(
                  title: "Help",
                  icon: Ionicons.help,
                  bgColor: Colors.red.shade100,
                  iconColor: Colors.red,
                  onTap: () {},
                ),

                const SizedBox(
                  height: 20,
                ),

                MyButton(buttonText: "Sing Out", ontap: signOut, height: 55)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
