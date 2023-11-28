// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Utilities/my_card.dart';
import 'package:razvoj_sofvera/activities_pages/breakfast.dart';
import 'package:razvoj_sofvera/activities_pages/dinner.dart';
import 'package:razvoj_sofvera/activities_pages/lunch.dart';
import 'package:razvoj_sofvera/activities_pages/tennis.dart';

class AllActivities extends StatelessWidget {
  const AllActivities({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(isDarkMode
                    ? 'lib/assets/darkBackground.jpg'
                    : 'lib/assets/lightBackground.jpg'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                //Breakfast
                Container(
                  margin: EdgeInsets.all(15),
                  child: MyCard(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Breakfast()));
                    },
                    picture: "lib/assets/Breakfast.jpg",
                    service_name: "Breakfast",
                    service_price: "7:00 AM - 10:00 AM",
                    height: 200,
                    width: double.infinity,
                  ),
                ),

                //Lunch
                Container(
                  margin: EdgeInsets.all(15),
                  child: MyCard(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Lunch()));
                    },
                    picture: "lib/assets/Lunch.jpg",
                    service_name: "Lunch",
                    service_price: "12:00 PM - 2:00 PM",
                    height: 200,
                    width: double.infinity,
                  ),
                ),

                //Dinner
                Container(
                  margin: EdgeInsets.all(15),
                  child: MyCard(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Dinner()));
                    },
                    picture: "lib/assets/Dinner.jpg",
                    service_name: "Dinner",
                    service_price: "6:30 PM - 8:30 PM",
                    height: 200,
                    width: double.infinity,
                  ),
                ),

                //Tennis
                Container(
                  margin: EdgeInsets.all(15),
                  child: MyCard(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Tennis()));
                    },
                    picture: "lib/assets/Tennis.jpg",
                    service_name: "Tennis Courts",
                    service_price: "3:00 PM - 9:00 PM",
                    height: 200,
                    width: double.infinity,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
