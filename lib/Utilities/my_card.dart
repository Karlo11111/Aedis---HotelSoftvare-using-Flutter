// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCard extends StatelessWidget {
  final String picture;
  final Function() onTap;
  final String service_name;
  final String service_price;

  const MyCard({
    super.key,
    required this.picture,
    required this.onTap,
    required this.service_name,
    required this.service_price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      //velicina card-a
      child: Container(
        width: 260,
        height: 200,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //slika
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        picture,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),

                Divider(
                  thickness: 2,
                  color: Colors.black,
                ),
                //naziv usluge i cijena

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      service_name,
                      style: GoogleFonts.inter(fontSize: 15),
                    ),
                    Text(
                      service_price,
                      style: GoogleFonts.inter(fontSize: 15),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
