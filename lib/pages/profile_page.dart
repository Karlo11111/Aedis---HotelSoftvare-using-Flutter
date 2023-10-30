// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  String name = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    try {
      DocumentSnapshot result = await FirebaseFirestore.instance
          .collection('User Email')
          .doc(user!.uid)
          .get();
      if (result.exists) {
        setState(() {
          name = result.get('Name');
        });
      } else {
        print('No document found for user');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Hello ' + name),
      ),
    );
  }
}
