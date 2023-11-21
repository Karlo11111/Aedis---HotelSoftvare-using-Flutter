// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:razvoj_sofvera/authentification/auth.dart';
import 'package:razvoj_sofvera/authentification/firebase_options.dart';
import 'package:razvoj_sofvera/authentification/onBoarding_screen_auth.dart';
import 'package:razvoj_sofvera/theme/theme.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //INITALIZE HIVE
  await Hive.initFlutter();
  // open the box for saving users name
  var box = await Hive.openBox('UserInfo');

  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstAuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
    );
  }
}
