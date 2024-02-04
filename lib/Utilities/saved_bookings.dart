// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class SavedBookings extends StatelessWidget {
  final String timeSlot;
  final String? healthIssuesText;
  final int? price;
  final String user;
  final Timestamp DateOfBooking;
  final String serviceType;
  SavedBookings(
      {super.key,
      required this.timeSlot,
      required this.user,
      required this.DateOfBooking,
      required this.serviceType,
      this.healthIssuesText,
      this.price});

  late DateTime dateTime = DateOfBooking.toDate();
  late String priceText =
      price == null || price == 0 ? "Free of charge" : "$price €";

  // Format the timestamp to display only the month and day
  late String formattedDate = DateFormat.yMMMd().format(dateTime);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isDarkMode ? Color.fromARGB(255, 15, 59, 100) : Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        serviceType,
                        style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 24),
                          SizedBox(width: 10),
                          Text(
                            formattedDate + "\n" + timeSlot,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.person,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 24),
                          SizedBox(width: 10),
                          Text(
                            user,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 85, bottom: 20),
                child: VerticalDivider(
                  thickness: 1.5,
                  width: 1,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "",
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Row(
                        children: [
                          Icon(Icons.heart_broken,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 24),
                          SizedBox(width: 10),
                          //health issues column
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Health Issues:",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              Text(
                                healthIssuesText ?? "None",
                                style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.label_important_rounded,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 24),
                          SizedBox(width: 10),
                          Text(
                            priceText,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
