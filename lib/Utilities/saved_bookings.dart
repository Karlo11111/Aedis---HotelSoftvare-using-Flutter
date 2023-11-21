// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SavedBookings extends StatelessWidget {
  final String timeSlot;
  final String user;
  final Timestamp DateOfBooking;
  final String serviceType;
  SavedBookings(
      {super.key,
      required this.timeSlot,
      required this.user,
      required this.DateOfBooking,
      required this.serviceType});

  late DateTime dateTime = DateOfBooking.toDate();

  // Format the timestamp to display only the month and day
  late String formattedDate = DateFormat.yMMMd().format(dateTime);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Colors.grey.shade400,
              Colors.grey.shade500,
              Colors.grey.shade600,
              Colors.grey.shade700,
            ]),
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 25,
      ),
      child: Wrap(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 12,
              bottom: 12,
              right: 12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //service type text
                    Text(
                      serviceType,
                      style:
                          GoogleFonts.inter(fontSize: 18, color: Colors.black),
                    ),
                    //time of booking text
                    Text(
                      "at " + timeSlot,
                      style:
                          GoogleFonts.inter(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //username text
                    Text(
                      user,
                      style:
                          GoogleFonts.inter(fontSize: 18, color: Colors.black),
                    ),
                    //date text
                    Text(
                      formattedDate.toString(),
                      style:
                          GoogleFonts.inter(fontSize: 18, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
