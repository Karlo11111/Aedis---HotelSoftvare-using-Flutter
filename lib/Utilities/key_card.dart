// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyCard extends StatefulWidget {
  final double height;
  final Widget topView;

  const KeyCard({
    required this.height,
    required this.topView,
    Key? key,
  }) : super(key: key);

  @override
  State<KeyCard> createState() => _KeyCardState();
}

class _KeyCardState extends State<KeyCard> {
  bool isExpanded = false;

  void toggleExpanded() => setState(() => isExpanded = !isExpanded);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height / 1.2,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: widget.topView,
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
            alignment:
                isExpanded ? Alignment.topCenter : Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                height: widget.height / 2,
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(48, 88, 150, 1),
                                  Color(0xCC1BFFFF),
                                ])),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 20,
                      child: Row(
                        children: [
                          Icon(Icons.vpn_key_rounded, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            "Door number: 512",
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.house,
                          size: 50,
                          color: Colors.white,
                        ),
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
