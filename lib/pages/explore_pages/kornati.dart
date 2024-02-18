// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/pages/explore_pages/book_now/book_now_kornati.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class KornatiScreen extends StatelessWidget {
  const KornatiScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    double imageHeightFactor = 0.35;
    double containerOverlap = 60.0;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Image container with reduced height
          Container(
            height: MediaQuery.of(context).size.height * imageHeightFactor,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/kornati.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Adjusted white container
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * imageHeightFactor -
                  containerOverlap,
            ),
            child: Container(
              height:
                  MediaQuery.of(context).size.height * (1 - imageHeightFactor) +
                      containerOverlap,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
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
                                "Traveling to kornati",
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Rating
                          Row(
                            children: [
                              Text(
                                "5.0",
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(Icons.star, color: Colors.yellow),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                            endIndent: 36,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Traveling to Kornati Island",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                "Diving appeals to adventure-seekers and marine \nenthusiasts, offering an immersive experience that \nshowcases underwater wonders.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                            endIndent: 36,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Map",
                                  style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Map
                          Padding(
                            padding: const EdgeInsets.only(right: 36),
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: const DecorationImage(
                                  image: AssetImage('lib/assets/map.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          // Book now button
                          Padding(
                            padding: const EdgeInsets.only(right: 36),
                            child: MyButton(
                              buttonText: "Book now!",
                              height: 40,
                              width: 300,
                              decorationColor: isDarkMode
                                  ? const Color.fromARGB(255, 38, 151, 255)
                                  : Theme.of(context).colorScheme.secondary,
                              borderColor: Colors.transparent,
                              textColor: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              icon: null,
                              ontap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const BookNowKornati()));
                              },
                            ),
                          ),
                        ],
                      ),
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
