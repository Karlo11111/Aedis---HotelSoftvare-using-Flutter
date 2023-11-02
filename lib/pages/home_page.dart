// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razvoj_sofvera/Utilities/my_card.dart';
import 'package:razvoj_sofvera/activities_pages/breakfast.dart';
import 'package:razvoj_sofvera/activities_pages/dinner.dart';
import 'package:razvoj_sofvera/activities_pages/lunch.dart';
import 'package:razvoj_sofvera/activities_pages/see_all_activities.dart';
import 'package:razvoj_sofvera/services_pages/massage.dart';
import 'package:razvoj_sofvera/services_pages/see_all_services.dart';
import 'package:razvoj_sofvera/services_pages/spa.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 233, 241),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Our services",
                  style: GoogleFonts.inter(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 40,
                ),
                //services text and see all button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Services",
                      style: GoogleFonts.inter(
                          fontSize: 26, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllServices()));
                        },
                        child: Text(
                          "See all",
                          style: GoogleFonts.inter(fontSize: 15),
                        ))
                  ],
                ),

                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),

                const SizedBox(
                  height: 20,
                ),
                //services cards

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //masaza
                      MyCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Massage()));
                        },
                        picture: "lib/assets/masaza.jpg",
                        service_name: "Massage",
                        service_price: "\$20/Per hour",
                        height: 200,
                        width: 260,
                      ),

                      //spa
                      MyCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Spa()));
                        },
                        picture: "lib/assets/spa.jpg",
                        service_name: "Spa",
                        service_price: "\$50/Per session",
                        height: 200,
                        width: 260,
                      ),

                      //room services

                      MyCard(
                        onTap: () {},
                        picture: "lib/assets/room_services.jpg",
                        service_name: "Room Services",
                        service_price: "",
                        height: 200,
                        width: 260,
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //activities text and see all button

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Activities",
                      style: GoogleFonts.inter(
                          fontSize: 26, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllActivities()));
                        },
                        child: Text(
                          "See all",
                          style: GoogleFonts.inter(fontSize: 15),
                        ))
                  ],
                ),

                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),

                const SizedBox(
                  height: 20,
                ),

                //activities cards

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //Breakfast
                      MyCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Breakfast()));
                        },
                        picture: "lib/assets/Breakfast.jpg",
                        service_name: "Breakfast",
                        service_price: "7:00 AM - 10:00 AM",
                        height: 200,
                        width: 260,
                      ),

                      //Lunch
                      MyCard(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Lunch()));
                        },
                        picture: "lib/assets/Lunch.jpg",
                        service_name: "Lunch",
                        service_price: "12:00 PM - 2:00 PM",
                        height: 200,
                        width: 260,
                      ),

                      //Dinner
                      MyCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Dinner()));
                        },
                        picture: "lib/assets/Dinner.jpg",
                        service_name: "Dinner",
                        service_price: "6:30 PM - 8:30 PM",
                        height: 200,
                        width: 260,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
