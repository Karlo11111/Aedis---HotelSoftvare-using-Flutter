import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookMassage extends StatefulWidget {
  const BookMassage({Key? key}) : super(key: key);

  @override
  State<BookMassage> createState() => _BookMassageState();
}

class _BookMassageState extends State<BookMassage> {
  // Variables for fetching data
  String userName = ''; // Set an initial value until the data is fetched
  User? user = FirebaseAuth.instance.currentUser;

  // Displaying a message for booking
  void displayMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  // Trying to fetch user data (in this case, their name)
  Future<void> _fetchUserName() async {
    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('User Email')
            .doc(user?.uid)
            .get();
        if (userDoc.exists) {
          String name = userDoc['Name'] as String;
          setState(() {
            userName = name;
          });
        } else {
          print('User document does not exist.');
        }
      } catch (error) {
        print('Error fetching user name: $error');
      }
    } else {
      print('No user is logged in.');
    }
  }

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 35),
          Container(
            height: 500,
            child: SfCalendar(
              view: CalendarView.month,
              onSelectionChanged: (CalendarSelectionDetails details) {
                setState(() {
                  selectedDate = details.date!;
                });
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('bookings').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    String userName = data['user'] ?? 'Unknown';
                    String time = data['time'] ?? 'No time';
                    return ListTile(
                      title: Text("$userName has a massage booked for $time"),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: selectedTime,
              );
              if (picked != null && picked != selectedTime)
                setState(() {
                  selectedTime = picked;
                });
            },
            child: Text('Select Time'),
          ),
          ElevatedButton(
            child: Text("Book Now"),
            onPressed: () {
              if (user != null) {
                FirebaseFirestore.instance.collection('bookings').add({
                  'date': selectedDate,
                  'time': selectedTime.format(context),
                  'user': userName, // Use the fetched user name here
                });
                displayMessage("Successfully booked");
              }
            },
          )
        ],
      ),
    );
  }
}
