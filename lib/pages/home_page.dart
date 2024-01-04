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
import 'package:razvoj_sofvera/activities_pages/see_all_activities.dart';
import 'package:razvoj_sofvera/explore_pages/diving.dart';
import 'package:razvoj_sofvera/explore_pages/see_all_explore_pages.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razvoj_sofvera/services_pages/see_all_services.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('UserInfo');

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
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
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.location_pin,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.chat,
                          color: Theme.of(context).colorScheme.secondary,
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
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            TextSpan(
                              text: "our hotel!",
                              style: GoogleFonts.inter(
                                  fontSize: 26.5,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Text(
                                "Click here to see your bookings.",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
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
                              color: Theme.of(context).colorScheme.secondary,
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
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeeAllExplore()));
                        },
                        child: MyContainer(
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
                                  ontap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DivingScreen()));
                                  },
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
                            )),

                        //kornati container
                        InfoContainer(
                            imagePath: "lib/assets/kornati.jpg",
                            title: "Traveling to Kornati",
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
                                "\nTraveling to Kornati, a stunning archipelago in Croatia, is a journey into serene, unspoiled natural paradise.",
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
                            )),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //services text and see all button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllServices()));
                        },
                        child: MyContainer(
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
                      ),
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
                        //massage container

                        InfoContainer(
                            imagePath: "lib/assets/masaza.jpg",
                            title: AppLocalizations.of(context)!.massage,
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
                                "Escape to the tranquility of a hotel massage, choose from various massage types and enhancements tailored to your preferences for a personalized experience.",
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
                            )),

                        //spa container
                        InfoContainer(
                            imagePath: "lib/assets/spa.jpg",
                            title: AppLocalizations.of(context)!.spa,
                            rating: Row(
                              children: [
                                Text(
                                  "4.9",
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
                            //text need to be changed
                            content:
                                "Escape to the tranquility of a hotel spa, choose from various massage types and enhancements tailored to your preferences for a personalized experience.",
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
                            )),

                        //room services container
                        InfoContainer(
                            imagePath: "lib/assets/room_services.jpg",
                            title: AppLocalizations.of(context)!.room_services,

                            //text need to be changed
                            content:
                                "Order any variety of things from drinks and cocktails to whole foods and snacks, and we will deliver it to your room.",
                            row: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  buttonText: "Order now!",
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
                              ],
                            )),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //activites text and see all button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Activities",
                        style: GoogleFonts.inter(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllActivities()));
                        },
                        child: MyContainer(
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
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        //breakfast container
                        InfoContainer(
                            imagePath: "lib/assets/Breakfast.jpg",
                            title: AppLocalizations.of(context)!.breakfast,

                            //text need to be changed
                            content:
                                "Enjoy a diverse breakfast selection from 7:00 AM to 10:00 AM. Choose from pastries, eggs, bacon, fresh fruits, and more in a welcoming atmosphere.",
                            row: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  buttonText: "Click to see more!",
                                  height: 35,
                                  width: 150,
                                  ontap: () {},
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  borderColor: Colors.transparent,
                                  textColor: Colors.white,
                                  icon: null,
                                  decorationColor: Colors.blue.shade900,
                                ),
                              ],
                            )),

                        //lunch container
                        InfoContainer(
                            imagePath: "lib/assets/Lunch.jpg",
                            title: AppLocalizations.of(context)!.lunch,

                            //text need to be changed
                            content:
                                "Experience an extended hotel lunch from 12:00 PM to 2:00 PM. Our menu includes international and local cuisines, ensuring a delectable journey...",
                            row: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  buttonText: "Click to see more!",
                                  height: 35,
                                  width: 150,
                                  ontap: () {},
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  borderColor: Colors.transparent,
                                  textColor: Colors.white,
                                  icon: null,
                                  decorationColor: Colors.blue.shade900,
                                ),
                              ],
                            )),

                        //dinner container
                        InfoContainer(
                            imagePath: "lib/assets/Dinner.jpg",
                            title: AppLocalizations.of(context)!.dinner,

                            //text need to be changed
                            content:
                                "Hotel dinners are a blend of luxury and culinary excellence. Whether you seek fine dining or a casual meal, we have you covered.",
                            row: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyButton(
                                  buttonText: "Click to see more!",
                                  height: 35,
                                  width: 150,
                                  ontap: () {},
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  borderColor: Colors.transparent,
                                  textColor: Colors.white,
                                  icon: null,
                                  decorationColor: Colors.blue.shade900,
                                ),
                              ],
                            )),
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
