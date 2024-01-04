// Add the persistent_bottom_nav_bar package import

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
  // PersistentTabController
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      SearchPage(),
      MyRoom(),
      OptionsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Ionicons.bed),
        title: AppLocalizations.of(context)!.my_services,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: AppLocalizations.of(context)!.my_room,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Ionicons.settings),
        title: AppLocalizations.of(context)!.settings,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      navBarHeight: 60,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
