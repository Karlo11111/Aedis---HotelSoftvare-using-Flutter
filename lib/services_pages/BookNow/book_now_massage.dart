// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookMassage extends StatefulWidget {
  const BookMassage({super.key});

  @override
  State<BookMassage> createState() => _BookMassageState();
}

class _BookMassageState extends State<BookMassage> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white10,
        elevation: 0,
      ),

      //body book forme

      body: SingleChildScrollView(
        child: Column(children: [
          TableCalendar(
            selectedDayPredicate: (day) => isSameDay(day, today),
            onDaySelected: _onDaySelected,
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: DateTime.utc(2023, 11),
          ),
          Text("Selected day is: ${today.toString().split(" ")[0]}")
        ]), 
      ),
    );
  }
}
