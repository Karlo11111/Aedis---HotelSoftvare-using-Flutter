// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class RoomCard extends StatelessWidget {
  final String picture;
  final String title;
  final IconData icon;
  final Function onTap;
  const RoomCard({
    super.key,
    required this.picture,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          width: 200,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isDarkMode ? Color.fromARGB(255, 15, 59, 100) : Colors.white,
          ),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Image.asset(
                  picture,
                  height: 230,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              ),
              //icons
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15),
                child: Icon(icon, color: Colors.white, size: 40.0),
              ),

              Positioned(
                bottom: 40,
                left: 15,
                child: Text(
                  "ALL YOUR DEVICES",
                  style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15, bottom: 12, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(title,
                          style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary)),

                      //forward icon
                      Icon(Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 16.0),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
