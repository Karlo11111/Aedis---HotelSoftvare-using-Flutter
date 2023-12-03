// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures, non_constant_identifier_names, avoid_print, sized_box_for_whitespace, prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

class BookSpa extends StatefulWidget {
  const BookSpa({super.key});

  @override
  State<BookSpa> createState() => _BookSpaState();
}

class _BookSpaState extends State<BookSpa> {
  //string for massage
  String massageText = "Spa";

  //map for checking if the booking limit is reached, takes a datetime and a bool
  Map<DateTime, bool> _bookingLimitReached = {};

  //fetch user auth
  User? user = FirebaseAuth.instance.currentUser;

  //include hive
  final myBox = Hive.box('UserInfo');

  // Declare necessary variables for saving the  available slots, timesslots and cached slots
  late DateTime _selectedDate;
  Map<DateTime, List<String>>? _availableTimeSlots;
  CollectionReference _timeSlotsCollection =
      FirebaseFirestore.instance.collection('SpaBookedTimeSlots');
  //all users booked collection
  CollectionReference _AllUsersBookedCollection =
      FirebaseFirestore.instance.collection('AllUsersBooked');

  late Map<DateTime, List<String>>? _cachedTimeSlots = {};

  //variable for today
  DateTime today = DateTime.now();

  // Initialize state when the widget is created
  @override
  void initState() {
    super.initState();
    // Set the selected date to now and fetch the available time slots
    _selectedDate = DateTime.now();
    _availableTimeSlots = {};
    //_availableTimeSlots![_selectedDate] = generateAvailableTimeSlotsx();
  }

  List<String> generateAvailableTimeSlots(DateTime selectedDate) {
    // Create a list of available time slots from 8:00 AM to 8:00 PM, 30 minutes apart
    List<String> timeSlots = [];
    DateTime now = DateTime.now();

    for (int hour = 8; hour <= 14.5; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        DateTime slot = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, hour, minute);
        if (selectedDate.day == now.day &&
            selectedDate.month == now.month &&
            selectedDate.year == now.year) {
          if (slot.isAfter(now)) {
            timeSlots.add(
                '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}');
          }
        } else {
          timeSlots.add(
              '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}');
        }
      }
    }
    return timeSlots;
  }

  Future<void> bookTimeSlot(String selectedTimeSlot) async {
    // Book a selected time slot if it's available
    if (_availableTimeSlots![_selectedDate]!.contains(selectedTimeSlot)) {
      setState(() {
        _availableTimeSlots![_selectedDate]!.remove(selectedTimeSlot);
      });
      // Update Firestore with the booking information and remove the booked time slot
      try {
        await _timeSlotsCollection
            .doc(_selectedDate.toLocal().toString())
            .update({
          'timeSlots': FieldValue.arrayRemove([selectedTimeSlot]),
        });
        //all users booked collection
        await _AllUsersBookedCollection.doc(_selectedDate.toLocal().toString())
            .update({
          'timeSlots': FieldValue.arrayRemove([selectedTimeSlot]),
        });
      } catch (e) {
        print('Firestore update error: $e');
      }
      //fetching the UserBookedMassage collection
      final userDocumentRef = FirebaseFirestore.instance
          .collection("UsersBookedSpa")
          .doc(user!.uid);
      final AllUserDocumentRef = FirebaseFirestore.instance
          .collection("AllUsersBooked")
          .doc(user!.uid);

      // Fetch the existing data for the user
      final userDocumentSnapshot = await userDocumentRef.get();

      final AllUserDocumentSnapshot = await AllUserDocumentRef.get();

      //check if the user document already exists
      if (userDocumentSnapshot.exists && AllUserDocumentSnapshot.exists) {
        // Get the existing appointments for the user
        List<dynamic> existingAppointments =
            userDocumentSnapshot.get('SpaAppointments') ?? [];

        // Filter the existing appointments for the selected date
        int appointmentsForSelectedDate =
            existingAppointments.where((appointment) {
          DateTime appointmentDate =
              (appointment['DateOfBooking'] as Timestamp).toDate();
          return DateTime(appointmentDate.year, appointmentDate.month,
                  appointmentDate.day) ==
              DateTime(
                  _selectedDate.year, _selectedDate.month, _selectedDate.day);
        }).length;

        print(appointmentsForSelectedDate);

        if (appointmentsForSelectedDate < 3) {
          // The user's document already exists, and there are fewer than 3 appointments for the selected date
          existingAppointments.add({
            'Name': myBox.get("username"),
            'Time': selectedTimeSlot,
            'DateOfBooking': _selectedDate,
            'TypeOfService': massageText,
          });
          //check if the appointmentsForSelectedDate are 2 (it goes from 0) and if it is it sets the booking limit to true
          if (appointmentsForSelectedDate == 2) {
            setState(() {
              _bookingLimitReached[_selectedDate] = true;
            });
          }

          // Update the user's document with the updated appointments
          await userDocumentRef.update({'SpaAppointments': existingAppointments});
          await AllUserDocumentRef.update(
              {'SpaAppointments': existingAppointments});
        } else {
          // The user has reached the limit of 3 appointments for the selected date
          setState(() {
            _bookingLimitReached[_selectedDate] = true;
          });
          print(
              'User has reached the limit of 2 appointments for the selected date.');
        }
      } else {
        // Create a new user document with the appointment
        await userDocumentRef.set({
          'SpaAppointments': [
            {
              'Name': myBox.get("username"),
              'Time': selectedTimeSlot,
              'DateOfBooking': _selectedDate,
              'TypeOfService': massageText,
            }
          ],
        });
        await AllUserDocumentRef.set({
          'SpaAppointments': [
            {
              'Name': myBox.get("username"),
              'Time': selectedTimeSlot,
              'DateOfBooking': _selectedDate,
              'TypeOfService': massageText,
            }
          ],
        });
      }
    }
  }

  Future<void> _fetchAvailableTimeSlots(DateTime date) async {
    // Always generate time slots for the selected date
    final generatedTimeSlots = generateAvailableTimeSlots(date);

    // Fetch data from Firestore
    final docReference = _timeSlotsCollection.doc(date.toLocal().toString());
    final docSnapshot = await docReference.get();

    if (docSnapshot.exists) {
      // Document already exists, fetch and cache the data
      final data = docSnapshot.data() as Map<String, dynamic>;
      final timeSlots = List<String>.from(data['timeSlots']);
      setState(() {
        _availableTimeSlots![date] = timeSlots;
        // Cache the data
        _cachedTimeSlots![date] = timeSlots;
      });
    } else {
      // If no data is available, store the generated time slots in Firestore
      await docReference.set({
        'timeSlots': generatedTimeSlots,
      });
    }

    // Always update the available time slots and cache with the generated time slots
    setState(() {
      _availableTimeSlots![date] = generatedTimeSlots;
      // Cache the data
      _cachedTimeSlots![date] = generatedTimeSlots;
    });
  }

  // This method is called when a day is selected in the table calendar.
  // It updates the selected date and fetches available time slots for the selected date.
  void _onDaySelected(DateTime selectedDate, DateTime focusedDay) async {
    setState(() {
      _selectedDate = selectedDate;
    });

    // Fetch available time slots
    await _fetchAvailableTimeSlots(_selectedDate);

    // Check if the user has reached the booking limit for the selected date
    final userDocumentRef = FirebaseFirestore.instance
        .collection("UsersBookedSpa")
        .doc(user!.uid);

    // Fetch the existing data for the user
    final userDocumentSnapshot = await userDocumentRef.get();

    if (userDocumentSnapshot.exists) {
      // Get the existing appointments for the user
      List<dynamic> existingAppointments =
          userDocumentSnapshot.get('SpaAppointments') ?? [];

      // Filter the existing appointments for the selected date
      int appointmentsForSelectedDate =
          existingAppointments.where((appointment) {
        DateTime appointmentDate =
            (appointment['DateOfBooking'] as Timestamp).toDate();
        return DateTime(appointmentDate.year, appointmentDate.month,
                appointmentDate.day) ==
            DateTime(
                _selectedDate.year, _selectedDate.month, _selectedDate.day);
      }).length;

      if (appointmentsForSelectedDate >= 3) {
        // The user has reached the limit of 3 appointments for the selected date
        setState(() {
          _bookingLimitReached[_selectedDate] = true;
        });

        // Show alert dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Booking Limit Reached"),
            content:
                Text("You have reached the maximum bookings for this date."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        // Reset the booking limit flag if the user has available slots
        setState(() {
          _bookingLimitReached[_selectedDate] = false;
        });
      }
    }
  }

  //displaying message for errors
  void displayAreYouSureBooking(
      String timeSlot, Function()? onTap, Function()? onTapCancel) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                        "Are you sure you want to book a Spa at $timeSlot"),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //CANCEL BUTTON
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    textStyle: MaterialStatePropertyAll(
                                        TextStyle(fontSize: 15))),
                                onPressed: onTapCancel,
                                child: Text("No, cancel"))),
                        SizedBox(width: 5),

                        //YES IM SURE BUTTON
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 50,
                            child: TextButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    textStyle: MaterialStatePropertyAll(
                                        TextStyle(fontSize: 15))),
                                onPressed: onTap,
                                child: Text("Yes I'm sure"))),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar for this screen
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        foregroundColor: Colors.black,
        title: Text("Book Your Spa"),
        centerTitle: true,
        elevation: 0,
      ),
      //body of the calendar and timeslots
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            focusedDay: _selectedDate,
            firstDay: today,
            lastDay: DateTime.now().add(Duration(days: 7)),
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) {
              return _selectedDate.isAtSameMomentAs(day);
            },
            headerStyle:
                HeaderStyle(titleCentered: true, formatButtonVisible: false),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemCount: _availableTimeSlots![_selectedDate]?.length ?? 0,
              itemBuilder: (context, index) {
                //selected timeslot
                final timeSlot = _availableTimeSlots![_selectedDate]![index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 90,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      //text button representing each timeslot
                      child: TextButton(
                        onPressed:
                            (_bookingLimitReached[_selectedDate] ?? false)
                                ? null
                                : () {
                                    displayAreYouSureBooking(timeSlot, () {
                                      bookTimeSlot(timeSlot);
                                      Navigator.pop(context);
                                    }, () {
                                      Navigator.pop(context);
                                    });
                                  },
                        child: Text(timeSlot),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}