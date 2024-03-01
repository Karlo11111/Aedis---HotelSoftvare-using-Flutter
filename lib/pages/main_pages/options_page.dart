// ignore_for_file: non_constant_identifier_names, avoid_print, prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kommunicate_flutter/kommunicate_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/Utilities/buttons.dart';
import 'package:razvoj_sofvera/Utilities/my_container.dart';
import 'package:razvoj_sofvera/Utilities/setting_item.dart';
import 'package:razvoj_sofvera/Utilities/setting_switch.dart';

import 'package:razvoj_sofvera/authentification/login_or_register.dart';
import 'package:razvoj_sofvera/pages/main_pages/Edit_account_screen.dart';
import 'package:razvoj_sofvera/pages/main_pages/help.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final myBox = Hive.box('UserInfo');

  void NavigateToAccPage() {
    setState(() {});
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            EditAccountScreen(refreshSettingsPage: NavigateToAccPage),
      ),
    );
  }

  void signOut() async {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginOrRegister()));
  }

  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('User Email')
            .doc(user.uid)
            .get();

        if (userDoc.exists) {
          String name = userDoc['Name'] as String;
          String email = userDoc['UserEmail'] as String;
          setState(() {
            myBox.put('username', name);
            myBox.put('email', email);
          });
        } else {
          print('User document does not exist.');
        }
      } catch (error) {
        print('Error fetching user name: $error');
      }
    } else {
      print('No user is logged in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //profile and notification icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile",
                        style: GoogleFonts.inter(
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        child: Icon(
                          Ionicons.notifications_outline,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 30,
                        ),
                      )
                    ],
                  ),

                  //profile picture and name
                  const SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            image: AssetImage('lib/assets/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            myBox.get('username') ?? 'Username',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Show profile',
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),

                      //edit profile button
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.32,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditAccountScreen(
                                      refreshSettingsPage: NavigateToAccPage)));
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  //talk to our chatbot
                  MyContainer(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decorationColor: isDarkMode
                        ? const Color.fromARGB(255, 15, 59, 100)
                        : Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You have some questions?",
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Text(
                                "Click here to talk to our chatbot!",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          FittedBox(
                              child: IconButton(
                            icon: Icon(
                              Icons.chat,
                              color: Theme.of(context).colorScheme.secondary,
                              size: 30,
                            ),
                            onPressed: () async {
                              dynamic conversationObject = {
                                'appId':
                                    'f117d6d09517976fd6b20d40acab19ed', // The [APP_ID](https://dashboard.kommunicate.io/settings/install) obtained from kommunicate dashboard.
                                'withPreChat': false
                              };
                              KommunicateFlutterPlugin.buildConversation(
                                      conversationObject)
                                  .then((clientConversationId) {
                                print("Conversation builder success : " +
                                    clientConversationId.toString());
                              }).catchError((error) {
                                print("Conversation builder error : " +
                                    error.toString());
                              });
                            },
                          )),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //settings

                  Text(
                    "Settings",
                    style: GoogleFonts.inter(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  //payment methods
                  SettingItem(
                    LeadingIcon: Ionicons.card_outline,
                    title: "Payments methods",
                    TrailingIcon: Icons.arrow_forward_ios,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //login and security

                  SettingItem(
                    LeadingIcon: Ionicons.lock_closed_outline,
                    title: "Login and security",
                    TrailingIcon: Icons.arrow_forward_ios,
                    onTap: () {},
                  ),
                  const SizedBox(
                    height: 5,
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //help
                  SettingItem(
                    LeadingIcon: Ionicons.help_outline,
                    title: "Help",
                    TrailingIcon: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HelpPage()));
                    },
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //language
                  SettingItem(
                    LeadingIcon: Ionicons.language_outline,
                    title: "Language",
                    TrailingIcon: Icons.arrow_forward_ios,
                    onTap: () {},
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  const Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),

                  //dark theme
                  SettingSwitch(
                    value: isDarkMode,
                    title: "Dark theme",
                    icon: Ionicons.moon_outline,
                    bgColor: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).colorScheme.secondary,
                    onTap: (value) {
                      setState(() {
                        isDarkMode = value;
                      });

                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme();
                    },
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  MyButton(
                    buttonText: "Sign out",
                    ontap: signOut,
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    decorationColor: isDarkMode
                        ? const Color.fromARGB(255, 38, 151, 255)
                        : Theme.of(context).colorScheme.secondary,
                    borderColor: Colors.transparent,
                    textColor: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
