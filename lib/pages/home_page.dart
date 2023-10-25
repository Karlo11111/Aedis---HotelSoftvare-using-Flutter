// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("aaaa"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: signOut,
                icon: const Icon(
                  Icons.logout,
                  size: 50,
                )),
            const SizedBox(
              height: 60,
            ),
            const Text(
              "SIGN OUT",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
            )
          ],
        ),
      ),
    );
  }
}
