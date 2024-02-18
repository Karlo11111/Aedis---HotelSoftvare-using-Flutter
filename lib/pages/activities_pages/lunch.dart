import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class Lunch extends StatelessWidget {
  const Lunch({Key? key});

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
                image: AssetImage('lib/assets/Lunch.jpg'),
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
                                "Lunch",
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
                                "Experience an extended hotel lunch from 12:00 PM to \n2:00 PM, creating a two-hour oasis of culinary delight in \nyour day.Our diverse lunch menu includes international and \nlocal cuisines, ensuring a delectable journey. Choose from \nrefreshing salads, succulent meats, or wholesome \nvegetarian options.",
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
                                "Enhance your dining experience with the soothing melodies of \nlive music, complemented by our attentive staff's impeccable \nservice, whether you're here for business or leisure. As the \nclock nears 2:00 PM, our dessert selection shines with an \narray of sweet treats, from rich cakes to delicate pastries \nand fresh fruits. Mark a special occasion or take a \nbreak from your daily routine, our extended hotel lunch \npromises to make lasting memories.",
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
