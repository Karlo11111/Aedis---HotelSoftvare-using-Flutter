import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/InfoContainer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/pages/services_pages/massage.dart';
import 'package:razvoj_sofvera/pages/services_pages/spa.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class AllServices extends StatefulWidget {
  const AllServices({Key? key}) : super(key: key);

  @override
  State<AllServices> createState() => _AllServicesState();
}

class _AllServicesState extends State<AllServices> {
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
                    'Services',
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
                          //massage
                          InfoContainer(
                              imagePath: 'lib/assets/masaza.jpg',
                              title: AppLocalizations.of(context)!.massage,
                              content:
                                  'Escape to the tranquility of a hotel massage, choose from various massage types and enhancements tailored to your preferences for a personalized experience.',
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
                                                  const MassageScreen()));
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

                          //spa
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
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  )
                                ],
                              ),
                              //text need to be changed
                              content:
                                  "Escape to the tranquility of a hotel spa, choose from various massage types and enhancements tailored to your preferences for a personalized experience.",
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
                                                  const SpaScreen()));
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
                          //room services
                          InfoContainer(
                              imagePath: "lib/assets/room_services.jpg",
                              title:
                                  AppLocalizations.of(context)!.room_services,

                              //text need to be changed
                              content:
                                  "Order any variety of things from drinks and cocktails to whole foods and snacks, and we will deliver it to your room.",
                              row: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
