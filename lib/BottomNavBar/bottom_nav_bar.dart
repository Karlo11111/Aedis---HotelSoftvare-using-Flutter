// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:razvoj_sofvera/pages/home_page.dart';
import 'package:razvoj_sofvera/pages/options_page.dart';
import 'package:razvoj_sofvera/pages/profile_page.dart';
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
    ProfilePage(),

    //settings page
    OptionsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: GNav(
        duration: Duration(milliseconds: 100), // tab animation duration
        gap: 8, // the tab button gap between icon and text
        color: Colors.grey[800], // unselected icon color
        activeColor: Colors.black, // selected icon and text color
        iconSize: 30, // tab button icon size
        tabBackgroundColor:
            Colors.black.withOpacity(0.1), // selected tab background color
        padding: EdgeInsets.symmetric(
            horizontal: 20, vertical: 10), // navigation bar padding
        onTabChange: (index) {
          goToPage(index);
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Home",
          ),
          GButton(
            icon: Icons.room_service,
            text: "My Services",
          ),
          GButton(
            icon: Icons.door_front_door,
            text: "My Room",
          ),
          GButton(
            icon: Icons.settings,
            text: "Settings",
          ),
        ],
      ),
    );
  }
}
