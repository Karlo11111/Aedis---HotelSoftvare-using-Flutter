import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  const MyContainer(
      {super.key,
      required this.width,
      required this.height,
      required this.child, required this.decorationColor});

  final double width;
  final double height;
  final Widget child;
  final Color decorationColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: decorationColor,
        borderRadius: BorderRadius.circular(30),
        //box shadow
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 196, 195, 195),
            offset: const Offset(
              2.0,
              2.0,
            ),
            blurRadius: 5.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
    );
  }
}
