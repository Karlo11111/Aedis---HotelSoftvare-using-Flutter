// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MyCardTest extends StatelessWidget {
  const MyCardTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color:
          Color.fromARGB(255, 0, 68, 136),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Image.asset(
              'lib/assets/masaza.jpg',
              fit: BoxFit.cover,
              height: 170, 
            ),
          ),

          // Card footer
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Service Name
                Text(
                  'Massage',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 216, 191, 47)),
                ),
                SizedBox(width: 88),
                // Price
                Text(
                  '\$20 per hour',
                  style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 216, 191, 47)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
