import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("AllUsersBooked")
                      .doc(user!.uid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.data() != null) {
                      var userData = snapshot.data!.data();

                      List<dynamic> allAppointments = [];

                      if (userData == null ||
                          (!userData.containsKey('MassageAppointments') &&
                              !userData.containsKey('SpaAppointments') &&
                              !userData
                                  .containsKey("DivingSessionAppointments") &&
                              !userData.containsKey('KornatiAppointments'))) {
                        return (Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cancel_presentation_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 70,
                            ),
                            Text(
                              AppLocalizations.of(context)!.appointments,
                              style: GoogleFonts.inter(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ));
                      }

                      if (userData.containsKey('MassageAppointments') &&
                          userData['MassageAppointments'] is List) {
                        allAppointments.addAll(userData['MassageAppointments']);
                      }

                      if (userData.containsKey('DivingSessionAppointments') &&
                          userData['DivingSessionAppointments'] is List) {
                        allAppointments
                            .addAll(userData['DivingSessionAppointments']);
                      }

                      if (userData.containsKey('KornatiAppointments') &&
                          userData['KornatiAppointments'] is List) {
                        allAppointments.addAll(userData['KornatiAppointments']);
                      }

                      if (userData.containsKey('SpaAppointments') &&
                          userData['SpaAppointments'] is List) {
                        allAppointments.addAll(userData['SpaAppointments']);
                      }
                      // Check if there are no appointments at all
                      if (allAppointments.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cancel_presentation_outlined,
                              color: Theme.of(context).colorScheme.primary,
                              size: 70,
                            ),
                            Text(
                              AppLocalizations.of(context)!.appointments,
                              style: GoogleFonts.inter(
                                  fontSize: 25,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        );
                      }

                      // Sort the appointments by date
                      allAppointments.sort((
                        a,
                        b,
                      ) {
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
                            bookingDate = (appointmentData['DateOfBooking']);
                          } else {
                            // Assume it's a Timestamp
                            bookingDate =
                                appointmentData['DateOfBooking'].toDate();
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
      ),
    );
  }
}
