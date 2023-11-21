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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("AllUsersBooked")
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var userData = snapshot.data!.data();

                    if (userData == null ||
                        (!userData.containsKey('MassageAppointments') &&
                            !userData.containsKey('SpaAppointments'))) {
                      return Text('No appointments found');
                    }

                    List<dynamic> allAppointments = [];

                    if (userData.containsKey('MassageAppointments')) {
                      allAppointments.addAll(userData['MassageAppointments']);
                    }

                    if (userData.containsKey('SpaAppointments')) {
                      allAppointments.addAll(userData['SpaAppointments']);
                    }

                    // Sort the appointments by date
                    allAppointments.sort((a, b) {
                      Timestamp dateA = a['DateOfBooking'];
                      Timestamp dateB = b['DateOfBooking'];
                      return dateA.compareTo(dateB);
                    });

                   return ListView.builder(
                      itemCount: allAppointments.length,
                      itemBuilder: (context, index) {
                        var appointmentData = allAppointments[index];

                        // Check if DateOfBooking is a string
                        
                        Timestamp bookingDate;
                        if (appointmentData['DateOfBooking'] is Timestamp) {
                          // Parse the string to DateTime if it's in a known format
                          bookingDate =
                              (appointmentData['DateOfBooking']);
                        } else {
                          // Assume it's a Timestamp
                          bookingDate =
                              appointmentData['DateOfBooking']
                                  .toDate();
                        }

                        return SavedBookings(
                          timeSlot: appointmentData['Time'],
                          user: appointmentData['Name'],
                          DateOfBooking: bookingDate,
                          serviceType: appointmentData['TypeOfService'],
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text("ERROR: ${snapshot.error}"));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
