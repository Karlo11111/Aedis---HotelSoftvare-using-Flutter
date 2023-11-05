// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, avoid_single_cascade_in_expression_statements, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class BookMassage extends StatefulWidget {
  const BookMassage({super.key});

  @override
  State<BookMassage> createState() => _BookMassageState();
}

class _BookMassageState extends State<BookMassage> {
  //variables for fetching data
  String UserName = ''; // Set an initial value until the data is fetched
  User? user = FirebaseAuth.instance.currentUser;
  //displaying message for booking
  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(message),
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    setState(() {});
  }

  //trying to fetch user data (in this case their name)
  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //trying to get the user uid from User Email collection and returns it as a string called UserName
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('User Email')
            .doc(user.uid)
            .get();
        //if userDoc (document specific to each user) exists it sets the Name field as a string called name
        if (userDoc.exists) {
          String name = userDoc['Name'] as String;
          setState(() {
            UserName = name;
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
      body: Column(children: [
        SizedBox(height: 35,),
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
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
        
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
        
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
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
            FirebaseFirestore.instance.collection('bookings')
              ..doc(user!.uid).set({
                'date': selectedDate,
                'time': selectedTime.format(context),
                //still need to change that the username is stored locally for this to work 
                'user': user!.displayName,
              });

            displayMessage("Successfully booked");
          },
        )
      ]),
    );
  }
}
