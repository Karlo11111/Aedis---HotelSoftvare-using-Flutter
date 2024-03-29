// Add the persistent_bottom_nav_bar package import

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/pages/main_pages/home_page.dart';
import 'package:razvoj_sofvera/pages/main_pages/my_room.dart';
import 'package:razvoj_sofvera/pages/main_pages/options_page.dart';
import 'package:razvoj_sofvera/pages/main_pages/services_page.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

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
    return const [
      HomePage(),
      MyRoom(),
      SearchPage(),
      OptionsPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home, color: Theme.of(context).colorScheme.secondary),
        title: 'Home',
      ),
      PersistentBottomNavBarItem(
        icon:
            Icon(Icons.person, color: Theme.of(context).colorScheme.secondary),
        title: AppLocalizations.of(context)!.my_room,
      ),
      PersistentBottomNavBarItem(
        icon:
            Icon(Ionicons.bed, color: Theme.of(context).colorScheme.secondary),
        title: AppLocalizations.of(context)!.my_services,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Ionicons.settings,
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: AppLocalizations.of(context)!.settings,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor:
          isDarkMode ? const Color.fromARGB(194, 46, 53, 94) : Colors.white,
      handleAndroidBackButtonPress: true,
      navBarHeight: 60,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
