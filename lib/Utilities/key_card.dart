// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KeyCard extends StatefulWidget {
  final double height;
  final Widget topView;

  const KeyCard({
    required this.height,
    required this.topView,
    super.key,
  });

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
                            borderRadius: BorderRadius.circular(16),
                            color: Color.fromARGB(255, 118, 144, 175),
                            image: DecorationImage(
                                image: AssetImage('lib/assets/keyCard.jpg'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.nfcSymbol,
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
