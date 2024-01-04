// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

class DivingScreen extends StatelessWidget {
  const DivingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double imageHeightFactor = 0.4;
    double containerOverlap = 60.0;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // Image container with reduced height
            Container(
              height: MediaQuery.of(context).size.height * imageHeightFactor,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/diving.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Adjusted white container
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * imageHeightFactor -
                      containerOverlap),
              child: Container(
                height: MediaQuery.of(context).size.height *
                        (1 - imageHeightFactor) +
                    containerOverlap,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 36.0,
                        top: 35,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Diving",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          //rating
                          Row(
                            children: [
                              Text(
                                "4.7",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.star, color: Colors.yellow),
                            ],
                          ),

                          SizedBox(height: 10),

                          Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                            endIndent: 36,
                          ),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              Text("Diving for beginners",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ],
                          ),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              Text(
                                  "Diving appeals to adventure-seekers and marine \nenthusiasts, offering an immersive experience that \nshowcases underwater wonders.",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),

                          SizedBox(height: 10),

                          Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                            endIndent: 36,
                          ),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              Text("Map",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ],
                          ),

                          SizedBox(height: 10),

                          //  Map

                          Padding(
                            padding: EdgeInsets.only(right: 36),
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: AssetImage('lib/assets/map.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}