// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razvoj_sofvera/pages/employee_pages/components/in_work_employee_list_tile.dart';

// InWorkTaskPage.dart
class InWorkTaskPage extends StatelessWidget {
  final Map<String, dynamic> task;

  const InWorkTaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // Replace with your actual field names
    String taskName = task['Name'];
    String taskStatus = task['Status'];

    return Scaffold(
      backgroundColor: const Color.fromRGBO(39, 44, 80, 1),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(68, 77, 132, 1),
        elevation: 0,
        title: // Employee page text
            Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Text(
              taskName,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display your task details here in the middle of the screen
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: InWorkEmployeeListTile(
                taskName: taskName,
                taskStatus: taskStatus,
                color: const Color.fromRGBO(68, 77, 132, 1),
                finishButton: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(38, 151, 255, 1))),
                  child: Text(
                    'Finish Task',
                    style: GoogleFonts.inter(
                      fontSize: 20.5,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    // Move the task to 'Finished' and pop back to the main page
                    moveTaskToFinished(taskName).then((_) {
                      Navigator.of(context)
                          .pop(); // Return to the main employee task page
                    }).catchError((error) {
                      print('Error moving task to Finished: $error');
                    });
                  },
                ),
              ),
            ),
            // Button at the bottom
          ],
        ),
      ),
    );
  }

  Future<void> moveTaskToFinished(String taskName) async {
    // References to the 'In Work' and 'Finished' documents
    DocumentReference inWorkDocRef =
        FirebaseFirestore.instance.collection('Tasks').doc('In Work');
    DocumentReference finishedDocRef =
        FirebaseFirestore.instance.collection('Tasks').doc('Finished');

    return FirebaseFirestore.instance.runTransaction((transaction) async {
      // Read the 'In Work' document
      DocumentSnapshot inWorkSnapshot = await transaction.get(inWorkDocRef);

      if (inWorkSnapshot.exists) {
        Map<String, dynamic> inWorkTasks = Map<String, dynamic>.from(
            inWorkSnapshot.data() as Map<String, dynamic>);

        // Check if the task exists in the 'In Work' document
        if (inWorkTasks.containsKey(taskName)) {
          // Prepare the task data to be moved to 'Finished'
          Map<String, dynamic> taskData = inWorkTasks[taskName];

          // Optionally, you can add a timestamp or other metadata to the taskData before moving it
          taskData['finishedAt'] = FieldValue.serverTimestamp();

          // Update the task's status to 'Finished'
          taskData['Status'] = 'Finished';

          // Write the task data to the 'Finished' document
          transaction.set(
              finishedDocRef, {taskName: taskData}, SetOptions(merge: true));

          // Remove the task from the 'In Work' document
          transaction.update(inWorkDocRef, {taskName: FieldValue.delete()});
        } else {
          throw Exception('Task does not exist in In Work!');
        }
      } else {
        throw Exception('In Work document does not exist!');
      }
    });
  }
}
