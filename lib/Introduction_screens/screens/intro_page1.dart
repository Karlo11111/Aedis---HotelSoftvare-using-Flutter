// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Image container
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/WelcomeToAedisPic1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // container
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.5 - 30),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.4 + 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //text: welcome to
                      Padding(
                        padding: const EdgeInsets.only(left: 36.0, top: 35),
                        child: Text(
                          "Welcome to",
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      //text: Aedis
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 36.0, bottom: 20, top: 0),
                        child: Text(
                          "Aedis",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 211, 155, 65),
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //other text
                  Padding(
                    padding: const EdgeInsets.only(left: 36.0, bottom: 16),
                    child: Text(
                      "Escape the Ordinary, Embrace the \nExtraordinary - Your Gateway to \nUnmatched Comfort and Unique \nExperiences.",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
