// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeviceCard extends StatefulWidget {
  final IconData icon;
  final String deviceName;
  final String roomOfDevice;
  const DeviceCard(
      {super.key,
      required this.icon,
      required this.deviceName,
      required this.roomOfDevice});

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),

      //container for the function
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
        height: MediaQuery.of(context).size.height / 5,
        width: MediaQuery.of(context).size.width / 2.2,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //icon and on$off switch
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //icon
                Icon(
                  widget.icon,
                  color: Theme.of(context).colorScheme.secondary,
                  size: 40,
                ),

                //switch
                CupertinoSwitch(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: isOn,
                    onChanged: (value) {
                      setState(() {
                        isOn = !isOn;
                      });
                    })
              ],
            ),

            SizedBox(height: MediaQuery.of(context).size.height / 17.5),

            //bedroom's device and Androiod tv text

            Text(
              widget.roomOfDevice,
              style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),

            Text(
              widget.deviceName,
              style: GoogleFonts.inter(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
