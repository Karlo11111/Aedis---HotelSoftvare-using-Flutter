// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:razvoj_sofvera/pages/home_page.dart';
import 'package:razvoj_sofvera/pages/my_room.dart';
import 'package:razvoj_sofvera/pages/options_page.dart';
import 'package:razvoj_sofvera/pages/search_page.dart';

class PagesPage extends StatefulWidget {
  const PagesPage({super.key});

  @override
  State<PagesPage> createState() => _PagesPageState();
}

class _PagesPageState extends State<PagesPage> {
  int currentIndex = 0;
  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  List _pages = [
    //Home Page
    HomePage(),

    //search page
    SearchPage(),

    //profile page
    MyRoom(),

    //settings page
    OptionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade800,
              blurRadius: 6,
            ),
          ],
          color: Color.fromARGB(255, 118, 144, 175),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
          child: GNav(
            onTabChange: (index) {
              goToPage(index);
            },
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Color.fromARGB(255, 36, 90, 156),
            gap: 5,
            iconSize: 24,
            padding: EdgeInsets.all(12),
            tabs: [
              GButton(
                icon: Icons.home,
                text: "Home",
                textStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              GButton(
                icon: Icons.room_service,
                text: "My Services",
                textStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              GButton(
                icon: Icons.door_front_door,
                text: "My Room",
                textStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              GButton(
                icon: Icons.settings,
                text: "Settings",
                textStyle: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
