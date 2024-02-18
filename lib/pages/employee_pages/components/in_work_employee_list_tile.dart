// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InWorkEmployeeListTile extends StatefulWidget {
  const InWorkEmployeeListTile(
      {super.key,
      required this.taskName,
      required this.taskStatus,
      required this.color,
      this.onTap,
      required this.finishButton});

  final String taskName;
  final Widget finishButton;
  final String taskStatus;
  final Function()? onTap;
  final Color color;

  @override
  State<InWorkEmployeeListTile> createState() => _InWorkEmployeeListTileState();
}

class _InWorkEmployeeListTileState extends State<InWorkEmployeeListTile> {
  // Variable to hold the until time
  late DateTime untilTime;

  @override
  void initState() {
    super.initState();
    // Calculate the until time as 30 minutes from now
    untilTime = DateTime.now().add(Duration(minutes: 30));
  }

  @override
  Widget build(BuildContext context) {
    String untilTimeString =
        "${untilTime.hour}:${untilTime.minute.toString().padLeft(2, '0')}";
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      decoration: BoxDecoration(
          color: widget.color, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your task: ${widget.taskName}",
              style: GoogleFonts.inter(
                fontSize: 22.5,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Task status: In Work",
              style: GoogleFonts.inter(
                fontSize: 20.5,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Until: $untilTimeString",
              style: GoogleFonts.inter(
                fontSize: 20.5,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Additional information: ",
              style: GoogleFonts.inter(
                fontSize: 20.5,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(39, 44, 80, 1),
                    borderRadius: BorderRadius.circular(16)),
                width: MediaQuery.of(context).size.width / 1.4,
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "No additional information is available, please contact an administrator for more information.",
                    style: GoogleFonts.inter(
                      fontSize: 15.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.4,
                child: widget.finishButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
