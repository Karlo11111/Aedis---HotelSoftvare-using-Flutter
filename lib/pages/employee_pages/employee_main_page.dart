// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razvoj_sofvera/pages/employee_pages/components/employee_list_tile.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({
    super.key,
  });

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Employee page text
              Text(
                "Employee page",
                style: GoogleFonts.inter(
                  fontSize: 26.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20), // Space between title and task list
              // StreamBuilder to get the employee's role
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Employees')
                    .doc(user!.email)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<DocumentSnapshot> employeeSnapshot) {
                  if (employeeSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!employeeSnapshot.hasData || employeeSnapshot.hasError) {
                    return const Center(
                        child: Text('Could not find employee data'));
                  }

                  var employeeData =
                      employeeSnapshot.data!.data() as Map<String, dynamic>;
                  String role = employeeData['employee'];

                  // StreamBuilder to listen to updates for tasks based on the role
                  return StreamBuilder<DocumentSnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Tasks')
                        .doc('Assigned')
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<DocumentSnapshot> tasksSnapshot) {
                      if (tasksSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!tasksSnapshot.hasData || tasksSnapshot.hasError) {
                        return const Center(
                            child: Text('Could not find tasks data'));
                      }

                      var tasksData =
                          tasksSnapshot.data!.data() as Map<String, dynamic>;
                      print(tasksData);
                      List<Map<String, dynamic>> tasksForRole = [];
                      tasksData.forEach((key, value) {
                        var taskData = Map<String, dynamic>.from(value);
                        if (taskData['Role'] == role) {
                          tasksForRole.add(taskData);
                        }
                      });

                      return Expanded(
                        child: ListView.builder(
                          itemCount: tasksForRole.length,
                          itemBuilder: (context, index) {
                            return EmployeeListTile(
                              taskName: tasksForRole[index]['Name'],
                              taskStatus:
                                  'Status: ${tasksForRole[index]['Status']}',
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
