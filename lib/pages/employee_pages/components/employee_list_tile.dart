// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class EmployeeListTile extends StatelessWidget {
  const EmployeeListTile(
      {super.key,
      required this.taskName,
      required this.taskStatus,
      this.onTap});

  final String taskName;
  final String taskStatus;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(16)),
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
            IconButton(onPressed: onTap, icon: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
