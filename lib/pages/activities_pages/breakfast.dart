import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class Breakfast extends StatelessWidget {
  const Breakfast({Key? key});

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
                image: AssetImage('lib/assets/Breakfast.jpg'),
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
                                "Breakfast",
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 38,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                            endIndent: 36,
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              Text(
                                "Enjoy a diverse breakfast selection from 7:00 AM to 10:00 AM. \nChoose from pastries, eggs, bacon, fresh fruits, and more in \na welcoming atmosphere.",
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
                          const Row(
                            children: [
                              Text(
                                "Our attentive staff ensures a great dining experience. Flexible \nbreakfast hours for your convenience.Start your day with a \nhearty meal that caters to all tastes, setting the perfect \ntone for your stay.",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
