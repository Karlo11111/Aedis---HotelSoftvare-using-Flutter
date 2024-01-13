// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/InfoContainer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/pages/activities_pages/breakfast.dart';
import 'package:razvoj_sofvera/pages/activities_pages/dinner.dart';
import 'package:razvoj_sofvera/pages/activities_pages/lunch.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class AllActivities extends StatefulWidget {
  const AllActivities({Key? key}) : super(key: key);

  @override
  State<AllActivities> createState() => _AllActivitiesState();
}

class _AllActivitiesState extends State<AllActivities> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor:
          isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
      body: Stack(
        children: <Widget>[
          // Content and AppBar
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop(); // Handles back button press
                    },
                  ),
                  title: Text(
                    'Activities',
                    style: GoogleFonts.inter(
                      color: Colors.black, // Text color
                      fontSize: 20, // Text size
                    ),
                  ),
                  backgroundColor:
                      Colors.transparent, // AppBar background color
                  elevation: 0, // Removes shadow below the AppBar
                ),
                // Rest of your page content
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Column(
                        children: [
                          //breakfast
                          InfoContainer(
                              imagePath: "lib/assets/Breakfast.jpg",
                              title: AppLocalizations.of(context)!.breakfast,

                              //text need to be changed
                              content:
                                  "Enjoy a diverse breakfast selection from 7:00 AM to 10:00 AM. Choose from pastries, eggs, bacon, fresh fruits, and more in a welcoming atmosphere.",
                              row: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyButton(
                                    buttonText: "Click to see more!",
                                    height: 35,
                                    width: 150,
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Breakfast()));
                                    },
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    borderColor: Colors.transparent,
                                    textColor: Colors.white,
                                    icon: null,
                                    decorationColor: Colors.blue.shade900,
                                  ),
                                ],
                              )),

                          //lunch
                          InfoContainer(
                              imagePath: "lib/assets/Lunch.jpg",
                              title: AppLocalizations.of(context)!.lunch,

                              //text need to be changed
                              content:
                                  "Experience an extended hotel lunch from 12:00 PM to 2:00 PM. Our menu includes international and local cuisines, ensuring a delectable journey...",
                              row: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyButton(
                                    buttonText: "Click to see more!",
                                    height: 35,
                                    width: 150,
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Lunch()));
                                    },
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    borderColor: Colors.transparent,
                                    textColor: Colors.white,
                                    icon: null,
                                    decorationColor: Colors.blue.shade900,
                                  ),
                                ],
                              )),

                          //dinner
                          InfoContainer(
                              imagePath: "lib/assets/Dinner.jpg",
                              title: AppLocalizations.of(context)!.dinner,

                              //text need to be changed
                              content:
                                  "Hotel dinners are a blend of luxury and culinary excellence. Whether you seek fine dining or a casual meal, we have you covered.",
                              row: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MyButton(
                                    buttonText: "Click to see more!",
                                    height: 35,
                                    width: 150,
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Dinner()));
                                    },
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    borderColor: Colors.transparent,
                                    textColor: Colors.white,
                                    icon: null,
                                    decorationColor: Colors.blue.shade900,
                                  ),
                                ],
                              )),

                          //tennis
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
