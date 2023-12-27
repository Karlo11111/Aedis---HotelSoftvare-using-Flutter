// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/InfoContainer.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/my_container.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentPage = 0;
  final _services_controler = PageController();

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _services_controler.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _services_controler.dispose();
  }

  final myBox = Hive.box('UserInfo');

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(isDarkMode ? '' : ''), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //services text and see all button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Croatia",
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () async {
                          dynamic conversationObject = {
                            'appId':
                                'f117d6d09517976fd6b20d40acab19ed', // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                            'withPreChat': false
                          };
                          KommunicateFlutterPlugin.buildConversation(
                                  conversationObject)
                              .then((clientConversationId) {
                            print("Conversation builder success : " +
                                clientConversationId.toString());
                          }).catchError((error) {
                            print("Conversation builder error : " +
                                error.toString());
                          });
                        },
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //welcome text
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.inter(
                            fontSize: 30,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  "Hi ${myBox.get('username')}, Welcome to \n",
                              style: GoogleFonts.inter(
                                fontSize: 26.5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            TextSpan(
                              text: "our hotel!",
                              style: GoogleFonts.inter(
                                  fontSize: 26.5,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //your bookings awaits you contaner

                  MyContainer(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decorationColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Your bookings awaits you!",
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                "Click here to see your bookings.",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          FittedBox(
                            child: Icon(
                              Ionicons.home_outline,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //explore and see all text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Explore!",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      MyContainer(
                        width: 100,
                        height: 30,
                        decorationColor: Color.fromARGB(255, 205, 155, 101),
                        child: Center(
                          child: Text(
                            "See all",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //cards
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //zadar container
                        InfoContainer(
                          imagePath: 'lib/assets/zadar.jpg',
                          title: 'About Zadar',
                          content:
                              'Zadar, a city rich in history and culture, is nestled along the Dalmatian coast of Croatia. With its origins dating back to the prehistoric times, it has been a significant hub through various eras including Roman...',
                        ),

                        //diving container
                        InfoContainer(
                            imagePath: "lib/assets/diving.jpg",
                            title: "Diving for beginners",
                            rating: Row(
                              children: [
                                Text(
                                  "4.5",
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                            content:
                                "Diving appeals to adventure-seekers and marine enthusiasts, offering an immersive experience that showcases underwater wonders.",
                            row: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  buttonText: "Book now!",
                                  height: 30,
                                  width: 100,
                                  ontap: () {},
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  borderColor: Colors.transparent,
                                  textColor: Colors.white,
                                  icon: null,
                                  decorationColor: Colors.blue.shade900,
                                ),
                                Text(
                                  "Price €100",
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
