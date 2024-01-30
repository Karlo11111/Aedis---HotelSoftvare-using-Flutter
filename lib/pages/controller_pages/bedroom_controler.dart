// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, avoid_unnecessary_containers, non_constant_identifier_names, unused_element

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/device_card.dart';

import 'package:razvoj_sofvera/theme/theme_provider.dart';

class BedroomController extends StatefulWidget {
  BedroomController({super.key});

  @override
  State<BedroomController> createState() => _BedroomControllerState();
}

//speed starter value
int _selectedIndex = 0;

//climate switch
bool climateSwitch = false;
bool CoolSwitch = false;
bool HeatSwitch = false;
bool DrySwitch = false;
bool AutoSwitch = false;

class _BedroomControllerState extends State<BedroomController> {
  //built button widget
  Widget _buildButton(int index, String text) {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: _selectedIndex == index ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  //default temp
  double _currentTemperature = 20;

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
                ),

                SizedBox(
                  height: 35,
                ),

                //temperature gauge
                Center(
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        _currentTemperature += details.delta.dy * 0.1;
                        _currentTemperature =
                            _currentTemperature.clamp(16.0, 30.0);
                      });
                    },
                    child: CustomPaint(
                      size: Size(200, 200),
                      painter: TemperatureGaugePainter(_currentTemperature),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //time off control
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      //icon
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 50,
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      //column for time and time what will turn off

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Time",
                            style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          Text(
                            "Time what will turn off",
                            style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                      ),

                      Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey)
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                //speed container
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      //icon
                      Icon(
                        Icons.speed_rounded,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 50,
                      ),

                      SizedBox(
                        width: 10,
                      ),

                      //column for time and time what will turn off

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Fan speed",
                            style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                          Text(
                            "Speed of fans spinning",
                            style: GoogleFonts.inter(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w400,
                                fontSize: 14),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),

                      Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton(0, "1x"),
                            _buildButton(1, "2x"),
                            _buildButton(2, "3x"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                //other devices
                SizedBox(
                  height: 20,
                ),

                Text("Other devices",
                    style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.w700,
                        fontSize: 22)),

                SizedBox(
                  height: 20,
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //android tv
                      DeviceCard(
                        icon: Icons.tv_rounded,
                        deviceName: "Android TV",
                        roomOfDevice: "Bedroom's device",
                      ),

                      SizedBox(
                        width: 20,
                      ),

                      //main light
                      DeviceCard(
                        icon: Icons.wb_sunny_outlined,
                        deviceName: "Main light",
                        roomOfDevice: "Bedroom's device",
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}

class TemperatureGaugePainter extends CustomPainter {
  final double temperature;

  TemperatureGaugePainter(this.temperature);

  @override
  void paint(Canvas canvas, Size size) {
    double startAngle = pi * 0.7;
    double sweepAngle = pi * 1.6;
    double currentSweepAngle = (temperature - 16) / (30 - 16) * sweepAngle;

    //drawing the arc
    final paintBackground = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width,
            height: size.height),
        startAngle,
        sweepAngle,
        false,
        paintBackground);

    // Draw the foreground arc
    final paintForeground = Paint()
      ..shader = LinearGradient(
        colors: [Colors.blue, Colors.red],
        stops: [0.0, 1.0],
      ).createShader(Rect.fromCenter(
          center: size.center(Offset.zero),
          width: size.width,
          height: size.height))
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Rect.fromCenter(
            center: size.center(Offset.zero),
            width: size.width,
            height: size.height),
        startAngle,
        currentSweepAngle,
        false,
        paintForeground);

    // Draw the temperature text
    final textSpan = TextSpan(
      text: '${temperature.toStringAsFixed(0)}°C',
      style: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(canvas,
        size.center(Offset(-textPainter.width / 2, -textPainter.height / 2)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
