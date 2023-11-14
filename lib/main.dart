// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: unused_import
import 'package:razvoj_sofvera/authentification/auth.dart';
import 'package:razvoj_sofvera/authentification/firebase_options.dart';
import 'package:razvoj_sofvera/authentification/onBoarding_screen_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //INITALIZE HIVE
  await Hive.initFlutter();
  // open the box for saving users name
  var box = await Hive.openBox('UserInfo');
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstAuthPage(),
    );
  }
}
