// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> docIDs = [];

  Future getDocID() async {
    await FirebaseFirestore.instance
        .collection("User Email")
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);

              docIDs.add(document.reference.id);
            }));
  }

  Future<String> getUserName() async {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
        .collection("User Email")
        .doc(docIDs[0])
        .get();
    return docSnapshot.get('Name');
  }

  String userName = '';

  @override
  void initState() {
    super.initState();
    fetchUserName();
  }

  fetchUserName() async {
    String name = await getUserName();
    setState(() {
      userName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Text('Hello ' + userName),
      ),
    );
  }
}
