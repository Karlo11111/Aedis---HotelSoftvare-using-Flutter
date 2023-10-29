import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razvoj_sofvera/Utilities/forward_button.dart';

class SettingSwitch extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final bool value;
  final Function(bool value) onTap;
  const SettingSwitch(
      {super.key,
      required this.title,
      required this.bgColor,
      required this.iconColor,
      required this.icon,
      required this.onTap,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: GoogleFonts.inder(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            value ? "On" : "Off",
            style: GoogleFonts.inder(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(
            width: 15,
          ),
          CupertinoSwitch(value: value, onChanged: onTap)
        ],
      ),
    );
  }
}
