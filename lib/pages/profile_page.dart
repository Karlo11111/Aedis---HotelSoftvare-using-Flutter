import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}
