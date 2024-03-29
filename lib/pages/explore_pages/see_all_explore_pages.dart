import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/InfoContainer.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/pages/explore_pages/diving.dart';
import 'package:razvoj_sofvera/pages/explore_pages/kornati.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class SeeAllExplore extends StatefulWidget {
  const SeeAllExplore({Key? key}) : super(key: key);

  @override
  State<SeeAllExplore> createState() => _SeeAllExploreState();
}

class _SeeAllExploreState extends State<SeeAllExplore> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: <Widget>[
          // Content and AppBar
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: isDarkMode ? Colors.white : Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop(); // Handles back button press
                    },
                  ),
                  title: Text(
                    'Explore',
                    style: GoogleFonts.inter(
                      color: isDarkMode
                          ? Colors.white
                          : Colors.black, // Text color
                      fontSize: 20, // Text size
                    ),
                  ),
                  backgroundColor:
                      Colors.transparent, // AppBar background color
                  elevation: 0, // Removes shadow below the AppBar
                ),
                // Rest of your page content
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Center(
                      child: Column(
                        children: [
                          const InfoContainer(
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
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                              content:
                                  "Diving appeals to adventure-seekers and marine enthusiasts, offering an immersive experience that showcases underwater wonders.",
                              row: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  const DivingScreen()));
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
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                              content:
                                  "Traveling to Kornati, a stunning archipelago in Croatia, is a journey into serene, unspoiled natural paradise.",
                              row: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                  const KornatiScreen()));
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
