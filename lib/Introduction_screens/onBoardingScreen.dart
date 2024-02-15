import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Introduction_screens/screens/intro_page1.dart';
import 'package:razvoj_sofvera/authentification/auth.dart';
import 'package:razvoj_sofvera/authentification/login_or_register.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            onLastPage = (index == 2);
          });
        },
        children: const [
          IntroPage1(),
        ],
      ),

      //dot indicator
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //next or done button
            if (onLastPage)
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const AuthPage();
                    }));
                  },
                  child: Container(
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(19)),
                      padding: const EdgeInsets.all(16),
                      child: const Center(
                          child: Text(
                        "DONE",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ))))
            else
              GestureDetector(
                  onTap: () {
                    //navigate to login page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginOrRegister()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.all(16),
                        child: const Center(
                            child: Text(
                          "CONTINUE",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ))),
                  )),
            const SizedBox(
              height: 40,
            ),
            //SmoothPageIndicator(controller: _controller, count: 3, effect: SlideEffect(activeDotColor: Colors.blue.shade900, dotWidth: 30, type: SlideType.normal, )),
          ],
        ),
      ),
    ]));
  }
}
