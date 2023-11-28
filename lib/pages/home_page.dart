// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:razvoj_sofvera/Utilities/GlassBox.dart';

import 'package:razvoj_sofvera/Utilities/my_card.dart';
import 'package:razvoj_sofvera/activities_pages/see_all_activities.dart';
import 'package:razvoj_sofvera/services_pages/massage.dart';
import 'package:razvoj_sofvera/services_pages/see_all_services.dart';

import 'package:razvoj_sofvera/services_pages/spa.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatelessWidget {
  final _services_controler = PageController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome",
                        style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.primary),
                      ),
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
                          service_name: "Massage",
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
                          service_name: "Spa",
                          service_price: "\$50/Per session",
                          height: 200,
                          width: 260,
                        ),

                        //room services card
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
                                  color: Colors.black,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Spa',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                  color: Colors.black,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Room Services',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                  color: Colors.black,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Activities',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
                                  color: Colors.black,
                                  size: 75,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Services',
                                  style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
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
