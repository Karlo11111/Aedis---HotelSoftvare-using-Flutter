// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _issueController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
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
        _emailController.clear();
        _issueController.clear();
        Navigator.pop(context);
      }).catchError((error) {
        print('Error submitting data: $error');
        // Handle errors here.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Help Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _issueController,
                decoration: InputDecoration(labelText: 'Issue Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please describe your issue';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
