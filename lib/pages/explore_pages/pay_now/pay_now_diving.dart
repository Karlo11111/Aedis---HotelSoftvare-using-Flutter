// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';

class DivingPayNow extends StatefulWidget {
  final DateTime checkInDate;
  const DivingPayNow({super.key, required this.checkInDate});

  @override
  State<DivingPayNow> createState() => _DivingPayNowState();
}

class _DivingPayNowState extends State<DivingPayNow> {
  int _counter = 0;
 @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(widget.checkInDate);
  }
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _healthIssuesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double imageHeightFactor = 0.35;
    double containerOverlap = 60.0;

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * imageHeightFactor,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/diving.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * imageHeightFactor -
                  containerOverlap,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 36.0,
                    right: 36.0,
                    top: 35,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Diving",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Rating: 4.7",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.star, color: Colors.yellow),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Guide: Antonio Kocijan",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Number of participants increment/decrement
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Number of participants: ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 5),
                          IconButton(
                            onPressed: _decrementCounter,
                            icon: Icon(Icons.remove),
                            color: Colors.black,
                            iconSize: 26,
                          ),
                          Text(
                            "$_counter",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: _incrementCounter,
                            icon: Icon(Icons.add),
                            color: Colors.black,
                            iconSize: 26,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      //name text field
                      MyTextField(
                        controller: _nameController,
                        hintText: "Name",
                        obscureText: false,
                      ),
                      SizedBox(height: 20),

                      //date text field
                      MyTextField(
                        controller: _dateController,
                        hintText: "Date",
                        obscureText: false,
                        enabled: false,
                      ),
                      SizedBox(height: 20),

                      //health issues text field
                      MyTextField(
                        controller: _healthIssuesController,
                        hintText: "Health issues",
                        obscureText: false,
                      ),
                      SizedBox(height: 20),

                      //pay now button
                      MyButton(
                        buttonText: "Pay now",
                        height: 50,
                        width: double.infinity,
                        decorationColor:
                            Theme.of(context).colorScheme.secondary,
                        borderColor: Colors.transparent,
                        textColor: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        icon: null,
                        ontap: () {},
                      ),
                      SizedBox(height: 20),

                      //apple pay button

                      MyButton(
                        buttonText: "Apple Pay",
                        height: 50,
                        width: double.infinity,
                        decorationColor: Colors.transparent,
                        borderColor: Colors.black,
                        textColor: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        icon: Icon(Icons.apple),
                        ontap: () {},
                      ),

                      //pressed accidentaly
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Press accidentaly?",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Go Back.",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
