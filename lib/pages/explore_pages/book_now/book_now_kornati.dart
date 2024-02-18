// ignore_for_file: non_constant_identifier_names, prefer_final_fields, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:razvoj_sofvera/pages/explore_pages/pay_now/pay_now_kornati.dart';
import 'package:table_calendar/table_calendar.dart';

class BookNowKornati extends StatefulWidget {
  const BookNowKornati({super.key});

  @override
  State<BookNowKornati> createState() => _BookNowKornatiState();
}

class _BookNowKornatiState extends State<BookNowKornati> {
  //string for kornati
  String Kornati = "Traveling to Kornati";

  //double for kornati price
  double KornatiPrice = 100;

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
      FirebaseFirestore.instance.collection('KornatiBookedTimeSlots');

  //hashmap for cashing the time slots
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
      if (mounted) {
        setState(() {
          _availableTimeSlots![_selectedDate]!.remove(selectedTimeSlot);
        });
      }
      // Update Firestore with the booking information and remove the booked time slot
      try {
        await _timeSlotsCollection.doc(_selectedDate.toLocal().toString()).set({
          'timeSlots': FieldValue.arrayRemove([selectedTimeSlot]),
        }, SetOptions(merge: true));
      } catch (e) {
        print('Firestore update error: $e');
      }
      final userDocumentRef = FirebaseFirestore.instance
          .collection("UsersBookedKornati")
          .doc(user!.uid);
      final AllUserDocumentRef = FirebaseFirestore.instance
          .collection("AllUsersBooked")
          .doc(user!.uid);

      final userDocumentSnapshot = await userDocumentRef.get();
      final AllUserDocumentSnapshot = await AllUserDocumentRef.get();

      if (userDocumentSnapshot.exists && AllUserDocumentSnapshot.exists) {
        List<dynamic> existingAppointments =
            userDocumentSnapshot.get('KornatiAppointments') ?? [];
        int appointmentsForSelectedDate =
            existingAppointments.where((appointment) {
          DateTime appointmentDate =
              (appointment['DateOfBooking'] as Timestamp).toDate();
          return DateTime(appointmentDate.year, appointmentDate.month,
                  appointmentDate.day) ==
              DateTime(
                  _selectedDate.year, _selectedDate.month, _selectedDate.day);
        }).length;

        if (appointmentsForSelectedDate < 1) {
          existingAppointments.add({
            'Name': myBox.get("username"),
            'Time': selectedTimeSlot,
            'DateOfBooking': _selectedDate,
            'TypeOfService': Kornati,
            'ServicePrice': KornatiPrice,
          });
          if (appointmentsForSelectedDate == 0) {
            if (mounted) {
              setState(() {
                _bookingLimitReached[_selectedDate] = true;
              });
            }
          }
          await userDocumentRef.set(
              {'KornatiAppointments': existingAppointments},
              SetOptions(merge: true));
          await AllUserDocumentRef.set(
              {'KornatiAppointments': existingAppointments},
              SetOptions(merge: true));
        } else {
          if (mounted) {
            setState(() {
              _bookingLimitReached[_selectedDate] = true;
            });
          }
          print(
              'User has reached the limit of 1 appointments for the selected date.');
        }
      } else {
        await userDocumentRef.set({
          'KornatiAppointments': [
            {
              'Name': myBox.get("username"),
              'Time': selectedTimeSlot,
              'DateOfBooking': _selectedDate,
              'TypeOfService': Kornati,
              'ServicePrice': KornatiPrice,
            }
          ],
        });
        await AllUserDocumentRef.set({
          'KornatiAppointments': [
            {
              'Name': myBox.get("username"),
              'Time': selectedTimeSlot,
              'DateOfBooking': _selectedDate,
              'TypeOfService': Kornati,
              'ServicePrice': KornatiPrice,
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
    final userDocumentRef =
        FirebaseFirestore.instance.collection("UsersKornati").doc(user!.uid);

    // Fetch the existing data for the user
    final userDocumentSnapshot = await userDocumentRef.get();

    if (userDocumentSnapshot.exists) {
      // Get the existing appointments for the user
      List<dynamic> existingAppointments =
          userDocumentSnapshot.get('Kornati') ?? [];

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
      if (appointmentsForSelectedDate >= 1) {
        // The user has reached the limit of 1 appointments for the selected date
        setState(() {
          _bookingLimitReached[_selectedDate] = true;
        });
        // Show alert dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Booking Limit Reached"),
            content: const Text(
                "You have reached the maximum bookings for this date."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
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
                        "Are you sure you want to book a Trip to Kornati Session at $timeSlot"),
                    const SizedBox(height: 40),
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
                                style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    textStyle: MaterialStatePropertyAll(
                                        TextStyle(fontSize: 15))),
                                onPressed: () {
                                  if (onTapCancel != null) onTapCancel();
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text("No, cancel"))),
                        const SizedBox(width: 5),

                        //YES IM SURE BUTTON
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.black, width: 3),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 50,
                            child: TextButton(
                                style: const ButtonStyle(
                                    foregroundColor:
                                        MaterialStatePropertyAll(Colors.black),
                                    textStyle: MaterialStatePropertyAll(
                                        TextStyle(fontSize: 15))),
                                onPressed: () {
                                  if (onTap != null) onTap();
                                  Navigator.pop(context); // Close the dialog
                                },
                                child: const Text("Yes I'm sure"))),
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
        title: const Text("Book Your Trip to Kornati "),
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
            lastDay: DateTime.now().add(const Duration(days: 7)),
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) {
              return _selectedDate.isAtSameMomentAs(day);
            },
            headerStyle: const HeaderStyle(
                titleCentered: true, formatButtonVisible: false),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: _timeSlotsCollection
                  .doc(_selectedDate.toLocal().toString())
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return const Text('No time slots available');
                }

                // Correctly cast the data
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;

                // Handle potential null or non-list values
                var timeSlotsData = data['timeSlots'];
                List<String> timeSlots = [];
                if (timeSlotsData is List) {
                  timeSlots = List<String>.from(timeSlotsData);
                }

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    //selected timeslot
                    final timeSlot = timeSlots[index];
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      KornatiPayNow(
                                                          checkInDate:
                                                              _selectedDate)));
                                        }, () {});
                                      },
                            child: Text(timeSlot),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
