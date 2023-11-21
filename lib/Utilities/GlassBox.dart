// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';

class GlassBox extends StatelessWidget {
  final child;
  const GlassBox({
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 12,
                sigmaY: 12,
              ),
              child: Container(),
            ),

            //box gradient
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                        Colors.white.withOpacity(0.4),
                        Colors.white.withOpacity(0.1),
                      ])),
            ),

            child
          ],
        ),
      ),
    );
  }
}
