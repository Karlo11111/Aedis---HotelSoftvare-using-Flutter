// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String? email = user!.email;
      String issue = _issueController.text;

      // Create a reference to the "Help" collection
      CollectionReference helpCollection =
          FirebaseFirestore.instance.collection("Help");

      // Add the form data to the "Help" collection
      helpCollection.add({
        'name': name,
        'email': email,
        'issue': issue,
        'timestamp': FieldValue.serverTimestamp(),
      }).then((value) {
        // Show a SnackBar with the success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Admin will contact you shortly',
              style: GoogleFonts.inter(fontSize: 20),
            ),
          ),
        );

        // Clear the form fields after successful submission
        _nameController.clear();
        _issueController.clear();
        Navigator.pop(context);
      }).catchError(
        (error) {
          print('Error submitting data: $error');
          // Handle errors here.
        },
      );
    }
  }

  //adding hive
  final myBox = Hive.box('UserInfo');

  //background email sender

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Username',
                    hintStyle: GoogleFonts.inder(
                        color: Theme.of(context).colorScheme.secondary)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _issueController,
                decoration: InputDecoration(
                    labelText: 'Issue Description',
                    hintStyle: GoogleFonts.inder(
                        color: Theme.of(context).colorScheme.secondary)),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please describe your issue';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  functions() {
                    _submitForm();
                  }

                  functions();
                },
                child: Text(
                  'Submit',
                  style: GoogleFonts.inder(
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
