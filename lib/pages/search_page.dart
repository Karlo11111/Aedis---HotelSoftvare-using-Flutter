// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:razvoj_sofvera/Utilities/saved_bookings.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //include hive
  final myBox = Hive.box('UserInfo');
  //fetch user auth
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("UsersBookedMassage")
                  .doc(user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var userData = snapshot.data!.data();

                  if (userData == null ||
                      !userData.containsKey('Appointments')) {
                    return Text('No appointments found');
                  }

                  var appointments = userData['Appointments'];

                  return ListView.builder(
                    itemCount: appointments.length,
                    itemBuilder: (context, index) {
                      var appointmentData = appointments[index];

                      return SavedBookings(
                        timeSlot: appointmentData['Time'],
                        user: appointmentData['Name'],
                        DateOfBooking: appointmentData['DateOfBooking'],
                        serviceType: appointmentData['TypeOfService'],
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("ERROR: ${snapshot.error}"));
                }
                return const Center(child: CircularProgressIndicator());
              },
            )

            )
          ],
        ),
      ),
    );
  }
}
