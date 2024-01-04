// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingItem extends StatelessWidget {
  final String title;
  final IconData LeadingIcon;
  final IconData TrailingIcon;
  final Function() onTap;

  const SettingItem({
    super.key,
    required this.title,
    required this.LeadingIcon,
    required this.TrailingIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  LeadingIcon,
                  color: Theme.of(context).primaryColor,
                  size: 25,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                  style: GoogleFonts.inter(fontSize: 16),
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.25, //20%),
            ),
            IconButton(
              onPressed: onTap,
              icon: Icon(
                TrailingIcon,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          ],
        )
      ],
    );
  }
}
