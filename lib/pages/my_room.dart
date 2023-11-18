// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:razvoj_sofvera/Utilities/devices_container.dart';
import 'package:razvoj_sofvera/Utilities/key_card.dart';
import 'package:razvoj_sofvera/Utilities/key_card_dialog.dart';
import 'package:razvoj_sofvera/Utilities/rooms_container.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, right: 25, top: 25),
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  child: KeyCard(
                    height: 380,
                    topView: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //welcome to your room text
                        Text(
                          "Welcome to your room ${myBox.get('username')}!",
                          style: GoogleFonts.inter(
                              fontSize: 26, fontWeight: FontWeight.w700),
                        ),

                        //sized box
                        SizedBox(height: 20),

                        //room key text
                        Text(
                          "Room Key",
                          style: GoogleFonts.inter(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //sized box
              SizedBox(height: 10),

              //room key text
              Text(
                "Rooms",
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),

              //sized box
              SizedBox(height: 10),

              //scrollable list of rooms (living room, bathroom, kitchen)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyRoomContainer(
                      name: "Living Room",
                      icon: FaIcon(
                        FontAwesomeIcons.couch,
                        size: 45,
                        color: Color.fromARGB(255, 118, 144, 175),
                      ),
                    ),
                    //sized box
                    SizedBox(width: 10),

                    MyRoomContainer(
                      name: "Bedroom",
                      icon: FaIcon(
                        FontAwesomeIcons.bed,
                        size: 45,
                        color: Color.fromARGB(255, 118, 144, 175),
                      ),
                    ),
                    //sized box
                    SizedBox(width: 10),

                    MyRoomContainer(
                      name: "Kitchen",
                      icon: FaIcon(
                        FontAwesomeIcons.kitchenSet,
                        size: 45,
                        color: Color.fromARGB(255, 118, 144, 175),
                      ),
                    ),
                    //sized box
                    SizedBox(width: 10),

                    MyRoomContainer(
                      name: "Bathroom",
                      icon: FaIcon(
                        FontAwesomeIcons.bath,
                        size: 45,
                        color: Color.fromARGB(255, 118, 144, 175),
                      ),
                    ),
                    //sized box
                    SizedBox(width: 10),
                  ],
                ),
              ),

              //sized box
              SizedBox(height: 10),

              //room key text
              Text(
                "Control your room",
                style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),

              //sized box
              SizedBox(height: 10),

              //devices
              //smart TV
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyDeviceContainer(
                      borderColor: Color.fromARGB(255, 197, 197, 196),
                      color: Color.fromARGB(255, 232, 93, 66),
                      text: "Smart TV",
                      image: Image.asset(
                          "lib/assets/355-3556340_flat-panel-tv-transparent-background-42-inch-tv-png-removebg-preview.png"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    MyDeviceContainer(
                      borderColor: Color.fromARGB(255, 232, 93, 66),
                      color: Color.fromARGB(255, 197, 197, 196),
                      text: "Smart TV",
                      image: Image.asset(
                          "lib/assets/355-3556340_flat-panel-tv-transparent-background-42-inch-tv-png-removebg-preview.png"),
                    ),
                  ],
                ),
              ),
              //Smart Light
            ],
          )),
        ),
      ),
    );
  }
}
