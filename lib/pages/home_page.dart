// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razvoj_sofvera/Utilities/my_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: GoogleFonts.inter(fontSize: 26),
                        ))
                  ],
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
                        onTap: () {},
                        picture: "lib/assets/masaza.jpg",
                        service_name: "Massage",
                        service_price: "\$20/Per hour",
                      ),

                      //spa
                      MyCard(
                        onTap: () {},
                        picture: "lib/assets/spa.jpg",
                        service_name: "Spa",
                        service_price: "\$50/Per session",
                      ),

                      MyCard(
                        onTap: () {},
                        picture: "lib/assets/room_services.jpg",
                        service_name: "Room Services",
                        service_price: "",
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
                        onPressed: () {},
                        child: Text(
                          "See all",
                          style: GoogleFonts.inter(fontSize: 26),
                        ))
                  ],
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
                        onTap: () {},
                        picture: "lib/assets/Breakfast.jpg",
                        service_name: "Breakfast",
                        service_price: "7:00 AM - 10:00 AM",
                      ),

                      //Lunch
                      MyCard(
                        onTap: () {},
                        picture: "lib/assets/Lunch.jpg",
                        service_name: "Lunch",
                        service_price: "12:00 PM - 2:00 PM",
                      ),

                      //Dinner
                      MyCard(
                        onTap: () {},
                        picture: "lib/assets/Dinner.jpg",
                        service_name: "Dinner",
                        service_price: "6:30 PM - 8:30 PM",
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
