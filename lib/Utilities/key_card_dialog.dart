// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class KeyCardDialog extends StatefulWidget {
  final void Function() onComplete;

  const KeyCardDialog({super.key, required this.onComplete});

  @override
  State<KeyCardDialog> createState() => _KeyCardDialogState();
}

class _KeyCardDialogState extends State<KeyCardDialog> {
  final animationDuration = Duration(seconds: 1);

  bool hasSlid = false;

  void slider() => setState(() => hasSlid = !hasSlid);

  void exit() async {
    setState(() => hasSlid = !hasSlid);
    await Future.delayed(animationDuration);
    if (mounted) Navigator.of(context).pop();
    widget.onComplete();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => slider());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Positioned.fill(
                child: GestureDetector(
                  onTap: exit,
                ),
              ),
            ),
            Positioned.fill(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 25, right: 25),
                    child: SizedBox(
                      height: 350,
                      child: AnimatedAlign(
                        alignment: hasSlid
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        duration: animationDuration,
                        curve: Curves.easeOutCubic,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            height: 190,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Center(
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: Color.fromARGB(
                                              255, 118, 144, 175),
                                          gradient: LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: [
                                                Color.fromRGBO(48, 88, 150, 1),
                                                Color(0xCC1BFFFF),
                                              ])),
                                    ),
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> openKeyCardDialog(BuildContext context,
    {required void Function() onComplete}) async {
  Navigator.of(context).push(
    PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) =>
          KeyCardDialog(onComplete: onComplete),
      transitionDuration: const Duration(milliseconds: 250),
    ),
  );
}
