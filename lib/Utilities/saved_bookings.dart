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
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 25,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 25,
          ),

          //title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
              ),
              Text(serviceType,
                  style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary)),
            ],
          ),

          SizedBox(
            height: 25,
          ),

          //date
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //icon
                  SizedBox(
                    width: 25,
                  ),

                  Icon(Icons.calendar_today,
                      color: Theme.of(context).colorScheme.secondary, size: 30),

                  SizedBox(
                    width: 10,
                  ),

                  Text(formattedDate + " \n" + timeSlot,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),

              SizedBox(
                height: 25,
              ),

              //number of people
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Icon(Icons.person,
                      color: Theme.of(context).colorScheme.secondary, size: 30),
                  SizedBox(
                    width: 10,
                  ),
                  Text(user,
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary)),
                ],
              ),
            ],
          ),

          //divider
        ],
      ),
    );
  }
}
