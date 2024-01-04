// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/authentification/firebase_options.dart';
import 'package:razvoj_sofvera/authentification/onBoarding_screen_auth.dart';
import 'package:razvoj_sofvera/l10n/l10n.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
      theme: Provider.of<ThemeProvider>(context).themeData,
      supportedLocales: L10n.all,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
    );
  }
}
