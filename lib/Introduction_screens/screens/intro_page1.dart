// ignore_for_file: prefer_const_constructors

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
              child: Padding(
                padding: const EdgeInsets.only(left: 36.0, top: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      "Aedis",
                      style: TextStyle(
                        color: Color.fromARGB(255, 211, 155, 65),
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                        height: 0.9,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Escape the Ordinary, Embrace the \nExtraordinary - Your Gateway to \nUnmatched Comfort and Unique \nExperiences.",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
