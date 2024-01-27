import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:razvoj_sofvera/theme/theme_provider.dart';

class BedroomController extends StatefulWidget {
  BedroomController({Key? key}) : super(key: key);

  @override
  State<BedroomController> createState() => _BedroomControllerState();
}

class _BedroomControllerState extends State<BedroomController> {
  bool climateSwitch = false;
  bool coolSwitch = false;
  bool heatSwitch = false;
  bool drySwitch = false;
  bool autoSwitch = false;

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        title: Text(
          "Bedroom",
          style: GoogleFonts.inter(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w700,
              fontSize: 28),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: isDarkMode ? Colors.black : Color.fromARGB(255, 242, 242, 242),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "AC climate",
                        style: GoogleFonts.inter(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                            fontSize: 22),
                      ),
                      CupertinoSwitch(
                          activeColor: Theme.of(context).colorScheme.secondary,
                          value: climateSwitch,
                          onChanged: (value) {
                            setState(() {
                              climateSwitch = value;
                            });
                          })
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _acModeButton(
                          context, "Cool", Icons.ac_unit_rounded, coolSwitch,
                          () {
                        setState(() {
                          coolSwitch = !coolSwitch;
                          heatSwitch = false;
                          drySwitch = false;
                          autoSwitch = false;
                        });
                      }),
                      _acModeButton(context, "Heat", Icons.whatshot, heatSwitch,
                          () {
                        setState(() {
                          heatSwitch = !heatSwitch;
                          coolSwitch = false;
                          drySwitch = false;
                          autoSwitch = false;
                        });
                      }),
                      _acModeButton(
                          context, "Auto", Icons.autorenew, autoSwitch, () {
                        setState(() {
                          autoSwitch = !autoSwitch;
                          coolSwitch = false;
                          drySwitch = false;
                          heatSwitch = false;
                        });
                      }),
                      _acModeButton(
                          context, "Dry", Icons.invert_colors, drySwitch, () {
                        setState(() {
                          drySwitch = !drySwitch;
                          coolSwitch = false;
                          heatSwitch = false;
                          autoSwitch = false;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CustomPaint(
                      size: Size(200, 200),
                      painter: GradientArcPainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _acModeButton(BuildContext context, String mode, IconData icon,
      bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 72,
        width: 72,
        decoration: BoxDecoration(
            color: isActive
                ? Theme.of(context).colorScheme.secondary
                : Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive
                  ? Colors.white
                  : Theme.of(context).colorScheme.secondary,
              size: 30,
            ),
            SizedBox(height: 5),
            Text(
              mode,
              style: GoogleFonts.inter(
                  color: isActive
                      ? Colors.white
                      : Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}

class GradientArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2);
    const Gradient gradient = LinearGradient(
        colors: <Color>[Colors.blue, Colors.green, Colors.red],
        stops: [0.0, 0.5, 1.0]);
    final Paint paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(rect, -pi / 2, 2 * pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
