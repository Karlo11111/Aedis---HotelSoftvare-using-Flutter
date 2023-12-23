// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names, prefer_interpolation_to_compose_strings, avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';

import 'package:razvoj_sofvera/Utilities/GlassBox.dart';

import 'package:razvoj_sofvera/Utilities/my_card.dart';
import 'package:razvoj_sofvera/activities_pages/see_all_activities.dart';
import 'package:razvoj_sofvera/services_pages/massage.dart';
import 'package:razvoj_sofvera/services_pages/see_all_services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razvoj_sofvera/services_pages/spa.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
                image: AssetImage(isDarkMode
                    ? 'lib/assets/darkBackground.jpg'
                    : 'lib/assets/lightBackground.jpg'),
                fit: BoxFit.cover)),
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
                      Text(
                        AppLocalizations.of(context)!.welcome,
                        style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary),
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
                            'withPreChat': true
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

                  Divider(
                      thickness: 1,
                      color: Theme.of(context).colorScheme.primary),

                  const SizedBox(
                    height: 20,
                  ),
                  //services indicator cards

                  SizedBox(
                    height: 220,
                    width: double.infinity,
                    child: PageView(
                      controller: _services_controler,
                      children: [
                        //massage card
                        MyCard(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Massage()));
                          },
                          picture: "lib/assets/masaza.jpg",
                          service_name: AppLocalizations.of(context)!.massage,
                          service_price: "\$20/Per hour",
                          height: 200,
                          width: 260,
                        ),

                        //spa card
                        MyCard(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => Spa()));
                          },
                          picture: "lib/assets/spa.jpg",
                          service_name: AppLocalizations.of(context)!.spa,
                          service_price: "\$50/Per session",
                          height: 200,
                          width: 260,
                        ),

                        //room services card
                        MyCard(
                          onTap: () {},
                          picture: "lib/assets/room_services.jpg",
                          service_name:
                              AppLocalizations.of(context)!.room_services,
                          service_price: "",
                          height: 200,
                          width: 260,
                        )
                      ],
                    ),
                  ),

                  //distance form cards to an indicator
                  SizedBox(
                    height: 20,
                  ),

                  //dot indicators
                  Center(
                      child: SmoothPageIndicator(
                    controller: _services_controler,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: Theme.of(context).colorScheme.secondary,
                        dotColor: Theme.of(context).colorScheme.primary,
                        spacing: 12),
                  )),

                  const SizedBox(
                    height: 15,
                  ),

                  //activities text and see all button
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      //spa glass box
                      GlassBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Spa(),
                              ),
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.spa,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.spa,
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //room services glass box
                      GlassBox(
                        child: GestureDetector(
                          onTap: () {},
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.door_front_door_sharp,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.room_services,
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //activities glass box
                      GlassBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllActivities(),
                              ),
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.run_circle_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.activities,
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //services glass box
                      GlassBox(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllServices(),
                              ),
                            );
                          },
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.room_service_sharp,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context)!.services,
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
