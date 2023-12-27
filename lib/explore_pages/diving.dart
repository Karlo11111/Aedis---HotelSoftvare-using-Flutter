// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(home: DivingScreen()));
}

class DivingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Stack to overlay the AppBar over the background image
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height *
                0.3, // Adjust the height accordingly
            child: Image.asset(
              'assets/diving_background.jpg', // Replace with your diving background image asset
              fit: BoxFit.cover,
            ),
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    'lib/assets/diving.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Diving for beginner',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              '4.7',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(Icons.star, color: Colors.amber),
                          ],
                        ),

                        Divider(
                          color: Colors.grey.shade400,
                          height: 20,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),

                        SizedBox(height: 16),
                        Text(
                          'Diving appeals to adventure-seekers and marine enthusiasts, offering an immersive experience that showcases underwater wonders.',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 16),

                        Divider(
                          color: Colors.grey.shade400,
                          height: 20,
                          thickness: 1,
                          indent: 0,
                          endIndent: 0,
                        ),
                        // Insert your Map widget here

                        Text(
                          "Map ",
                          style: GoogleFonts.inter(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          height: 200,
                          color: Colors.blue.shade100,
                          child: Center(child: Text('Map placeholder')),
                        ),
                        SizedBox(height: 16),

                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Book now!',
                              style: GoogleFonts.inter(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.blue.shade900, // Button color
                              foregroundColor: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
