// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'package:razvoj_sofvera/Utilities/key_card.dart';
import 'package:razvoj_sofvera/Utilities/key_card_dialog.dart';

import 'package:nfc_manager/nfc_manager.dart';
import 'package:razvoj_sofvera/Utilities/room_card.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class MyRoom extends StatefulWidget {
  const MyRoom({super.key});

  @override
  State<MyRoom> createState() => _MyRoomState();
}

class _MyRoomState extends State<MyRoom> {
  ValueNotifier<String> result = ValueNotifier<String>(
      ''); // Declare and initialize a ValueNotifier to hold a string value

  void ndefWrite() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        print('Tag is not ndef writable');
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Radi!'),
      ]);

      try {
        await ndef.write(message);
        print('Success to "Ndef Write"');
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value == e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  //include hive
  final myBox = Hive.box('UserInfo');

  //variables for fetching data
  String userName = ''; // Set an initial value until the data is fetched

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  //trying to fetch user data (in this case their name)
  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //trying to get the user uid from User Email collection and returns it as a string called userName
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('User Email')
            .doc(user.uid)
            .get();
        //if userDoc (document specific to each user) exists it sets the Name field as a string called name
        if (userDoc.exists) {
          String name = userDoc['Name'] as String;
          setState(() {
            userName = name;
          });
        } else {
          print('User document does not exist.');
        }
      } catch (error) {
        print('Error fetching user name: $error');
      }
    } else {
      print('No user is logged in.');
    }
  }

  bool usingKey = false;

  Future<void> toggleUsingKey() async {
    setState(() {
      usingKey = true;
    });

    openKeyCardDialog(
      context,
      onComplete: () {
        setState(() {
          usingKey = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                //room key container
                InkWell(
                  onTap: () {
                    funckije() {
                      toggleUsingKey();
                      ndefWrite();
                    }

                    funckije();
                  },
                  child: Opacity(
                    opacity: usingKey ? 0 : 1,
                    child: Container(
                      child: KeyCard(
                        height: 440,
                        topView: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // your room text
                            Text(
                              "Your Room",
                              style: GoogleFonts.inter(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),

                            //sized box
                            SizedBox(height: 20),

                            //room key text
                            Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Container(
                                height: 75,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Room Key",
                                        style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary),
                                      ),
                                      Text(
                                          "Touch the NFC sign with your mobile phone",
                                          style: GoogleFonts.inter(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //sized box

                SizedBox(height: 20),

                //your rooms container
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your Rooms",
                            style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Text("Select room to control smart devices",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color:
                                      Theme.of(context).colorScheme.secondary)),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                //your rooms container
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //bedroom
                      RoomCard(
                        title: "Bedroom",
                        picture: "lib/assets/bedroom.jpg",
                        icon: Ionicons.bed,
                        onTap: () {},
                      ),

                      SizedBox(width: 20),

                      //bathroom
                      RoomCard(
                        title: "Bathroom",
                        picture: "lib/assets/bathroom.jpg",
                        icon: Icons.shower,
                        onTap: () {},
                      ),

                      SizedBox(width: 20),

                      //living room

                      RoomCard(
                        title: "Living Room",
                        picture: "lib/assets/living_room.jpg",
                        icon: Ionicons.tv,
                        onTap: () {},
                      ),

                      SizedBox(width: 20),

                      //kitchen
                      RoomCard(
                        title: "Kitchen",
                        picture: "lib/assets/kitchen.jpg",
                        icon: Ionicons.restaurant,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
