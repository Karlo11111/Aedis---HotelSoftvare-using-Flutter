// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:razvoj_sofvera/Utilities/my_card.dart';
import 'package:razvoj_sofvera/services_pages/massage.dart';
import 'package:razvoj_sofvera/services_pages/spa.dart';

class AllServices extends StatelessWidget {
  const AllServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              //masaza
              MyCard(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Massage()));
                },
                picture: "lib/assets/masaza.jpg",
                service_name: "Massage",
                service_price: "\$20/Per hour",
                height: 200,
                width: double.infinity,
              ),

              //spa
              MyCard(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Spa()));
                },
                picture: "lib/assets/spa.jpg",
                service_name: "Spa",
                service_price: "\$50/Per session",
                height: 200,
                width: double.infinity,
              ),

              //room services
              MyCard(
                onTap: () {},
                picture: "lib/assets/room_services.jpg",
                service_name: "Room Services",
                service_price: "",
                height: 200,
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
