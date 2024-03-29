// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/text_fields.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class KornatiPayNow extends StatefulWidget {
  final DateTime checkInDate;
  const KornatiPayNow({super.key, required this.checkInDate});

  @override
  State<KornatiPayNow> createState() => _KornatiPayNowState();
}

class _KornatiPayNowState extends State<KornatiPayNow> {
  int _counter = 1;
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
      if (_counter > 1) {
        _counter--;
      }
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _healthIssuesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
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
                image: AssetImage('lib/assets/kornati.jpg'),
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
                color: Theme.of(context).colorScheme.background,
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
                        "Trip to Kornati",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "Rating: 4.5",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
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
                        "Guide: Božidar Klarić",
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
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
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              )),
                          SizedBox(width: 5),
                          IconButton(
                            onPressed: _decrementCounter,
                            icon: Icon(Icons.remove),
                            color: isDarkMode ? Colors.white : Colors.black,
                            iconSize: 26,
                          ),
                          Text(
                            "$_counter",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          IconButton(
                            onPressed: _incrementCounter,
                            icon: Icon(Icons.add),
                            color: isDarkMode ? Colors.white : Colors.black,
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
                        decorationColor: isDarkMode
                            ? Color.fromARGB(255, 38, 151, 255)
                            : Theme.of(context).colorScheme.secondary,
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
                        borderColor: isDarkMode ? Colors.white : Colors.black,
                        textColor: isDarkMode ? Colors.white : Colors.black,
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
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Go Back.",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Color.fromARGB(255, 38, 151, 255)
                                    : Theme.of(context).colorScheme.secondary,
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
