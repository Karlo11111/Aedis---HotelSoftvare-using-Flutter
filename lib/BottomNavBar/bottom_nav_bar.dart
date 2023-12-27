// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:razvoj_sofvera/pages/home_page.dart';
import 'package:razvoj_sofvera/pages/my_room.dart';
import 'package:razvoj_sofvera/pages/options_page.dart';
import 'package:razvoj_sofvera/pages/search_page.dart';

class PagesPage extends StatefulWidget {
  const PagesPage({super.key});

  @override
  State<PagesPage> createState() => _PagesPageState();
}

class _PagesPageState extends State<PagesPage> {
  int currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    MyRoom(),
    OptionsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        iconSize: 22,
        selectedIconTheme: IconThemeData(size: 28),
        unselectedIconTheme: IconThemeData(size: 24),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.home),
            ),
            label: 'Home',
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Ionicons.bed),
            ),
            label: AppLocalizations.of(context)!.my_services,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.person),
            ),
            label: AppLocalizations.of(context)!.my_room,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Ionicons.settings),
            ),
            label: AppLocalizations.of(context)!.settings,
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
