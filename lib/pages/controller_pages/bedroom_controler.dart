// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class BedroomController extends StatefulWidget {
  BedroomController({super.key});

  @override
  State<BedroomController> createState() => _BedroomControllerState();
}

//climate switch
bool climateSwitch = false;
bool CoolSwitch = false;
bool HeatSwitch = false;
bool DrySwitch = false;
bool AutoSwitch = false;

class _BedroomControllerState extends State<BedroomController> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          "Bedroom",
          style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w700,
              fontSize: 28),
        ),
      ),

      //body
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //AC on/off switch and text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "AC climate",
                      style: GoogleFonts.inter(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 22),
                    ),

                    //AC switch
                    CupertinoSwitch(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: climateSwitch,
                        onChanged: (value) {
                          setState(() {
                            climateSwitch = value;
                          });
                        })
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                //ac modes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //cool mode
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          CoolSwitch = !CoolSwitch;
                          HeatSwitch = false;
                          DrySwitch = false;
                          AutoSwitch = false;
                        });
                      },
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            color: CoolSwitch
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Icon(
                              Icons.ac_unit_rounded,
                              color: CoolSwitch
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.secondary,
                              size: 30,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Cool",
                              style: GoogleFonts.inter(
                                  color: CoolSwitch
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),

                    //heat mode
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          HeatSwitch = !HeatSwitch;
                          CoolSwitch = false;
                          DrySwitch = false;
                          AutoSwitch = false;
                        });
                      },
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            color: HeatSwitch
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Image(
                              image: Svg("lib/assets/heat.svg"),
                              height: 30,
                              width: 30,
                              color: HeatSwitch
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Heat",
                              style: GoogleFonts.inter(
                                  color: HeatSwitch
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),

                    //auto mode
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          AutoSwitch = !AutoSwitch;
                          CoolSwitch = false;
                          DrySwitch = false;
                          HeatSwitch = false;
                        });
                      },
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            color: AutoSwitch
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Image(
                              image: Svg("lib/assets/auto.svg"),
                              height: 30,
                              width: 30,
                              color: AutoSwitch
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Auto",
                              style: GoogleFonts.inter(
                                  color: AutoSwitch
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),

                    //dry mode
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          DrySwitch = !DrySwitch;
                          CoolSwitch = false;
                          HeatSwitch = false;
                          AutoSwitch = false;
                        });
                      },
                      child: Container(
                        height: 72,
                        width: 72,
                        decoration: BoxDecoration(
                            color: DrySwitch
                                ? Theme.of(context).colorScheme.secondary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Image(
                              image: Svg("lib/assets/dry.svg"),
                              height: 30,
                              width: 30,
                              color: DrySwitch
                                  ? Colors.white
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Dry",
                              style: GoogleFonts.inter(
                                  color: DrySwitch
                                      ? Colors.white
                                      : Theme.of(context).colorScheme.secondary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
