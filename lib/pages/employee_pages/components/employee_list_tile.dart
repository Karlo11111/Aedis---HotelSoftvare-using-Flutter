// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile(
      {super.key,
      required this.iconButtonYes,
      required this.taskName,
      required this.taskStatus,
      required this.color,
      this.onTap});

  final String taskName;
  final String taskStatus;
  final Function()? onTap;
  final bool iconButtonYes;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(taskName),
                Text(taskStatus),
              ],
            ),
            iconButtonYes
                ? IconButton(onPressed: onTap, icon: Icon(Icons.add))
                : Container(),
          ],
        ),
      ),
    );
  }
}
