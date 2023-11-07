// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures, non_constant_identifier_names, avoid_print, sized_box_for_whitespace, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class BookMassage extends StatefulWidget {
  const BookMassage({super.key});

  @override
  State<BookMassage> createState() => _BookMassageState();
}

class _BookMassageState extends State<BookMassage> {
  late DateTime _selectedDate;
  Map<DateTime, List<String>>? _availableTimeSlots;
  CollectionReference _timeSlotsCollection =
  FirebaseFirestore.instance.collection('MassageBookedTimeSlots');
  late Map<DateTime, List<String>>? _cachedTimeSlots = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _availableTimeSlots = {};
    _availableTimeSlots![_selectedDate] = generateAvailableTimeSlots();
    _fetchAvailableTimeSlots(_selectedDate);
  }

  List<String> generateAvailableTimeSlots() {
    // Create a list of available time slots from 8:00 AM to 8:00 PM, 30 minutes apart
    List<String> timeSlots = [];
    for (int hour = 8; hour < 20; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        timeSlots.add(
            '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}');
      }
    }
    return timeSlots;
  }

  Future<void> bookTimeSlot(String selectedTimeSlot) async {
    if (_availableTimeSlots![_selectedDate]!.contains(selectedTimeSlot)) {
      setState(() {
        _availableTimeSlots![_selectedDate]!.remove(selectedTimeSlot);
      });
      // Update Firestore with the booking information and remove the booked time slot
      await _timeSlotsCollection
          .doc(_selectedDate.toLocal().toString())
          .update({
        'timeSlots': FieldValue.arrayRemove([selectedTimeSlot])
      });
    }
  }

  Future<void> _fetchAvailableTimeSlots(DateTime date) async {
    if (_cachedTimeSlots!.containsKey(date)) {
      // Use cached data if available
      setState(() {
        _availableTimeSlots![date] = _cachedTimeSlots![date]!;
      });
    } else {
      // Fetch data from Firestore if not in cache
      final snapshot =
          await _timeSlotsCollection.doc(date.toLocal().toString()).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        final timeSlots = List<String>.from(data['timeSlots']);
        setState(() {
          _availableTimeSlots![date] = timeSlots;
          // Cache the data
          _cachedTimeSlots![date] = timeSlots;
        });
      } else {
        // If no data is available, generate time slots and store in Firestore
        final generatedTimeSlots = generateAvailableTimeSlots();
        await _timeSlotsCollection.doc(date.toLocal().toString()).set({
          'timeSlots': generatedTimeSlots,
        });
        setState(() {
          _availableTimeSlots![date] = generatedTimeSlots;
          // Cache the data
          _cachedTimeSlots![date] = generatedTimeSlots;
        });
      }
    }
  }

  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDate;
    });
    _fetchAvailableTimeSlots(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          TableCalendar(
            calendarFormat: CalendarFormat.week,
            focusedDay: _selectedDate,
            firstDay: DateTime(2023),
            lastDay: DateTime(2024),
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              itemCount: _availableTimeSlots![_selectedDate]?.length ?? 0,
              itemBuilder: (context, index) {
                final timeSlot = _availableTimeSlots![_selectedDate]![index];
                return TextButton(
                  onPressed: () {
                    bookTimeSlot(timeSlot);
                  },
                  child: Text(timeSlot),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
