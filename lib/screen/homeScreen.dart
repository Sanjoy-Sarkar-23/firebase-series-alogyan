import 'package:firebase_series/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController ac = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HomeScreen")),
      // body: ListView(
      //   children: [
      //     Row(children: []),
      //     titleCard("Hello", "This sample design card", false),
      //     titleCard("Hello1", "This sample design card", false),
      //     titleCard("Hello2", "This sample design card", true),
      //     titleCard("Hello3", "This sample design card", false),
      //     titleCard("Hello4", "This sample design card", false),
      //     titleCard("Hello5", "This sample design card", true),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(children: [Text("Todo list")]),
            SizedBox(height: 10),
            //Expanded Widget
            SizedBox(
              height: 1000,
              //SingleChildScrollView Widget
              child: ListView.builder(
                itemCount: ac.tasks.length,

                itemBuilder: (context, index) {
                  final task = ac.tasks[index];
                  return titleCard(
                    task.title,
                    task.description,
                    task.isCompleted,
                    task.createdAt,
                  );
                },
              ),
            ),
            // titleCard("Hello", "This sample design card", false), // old method not scale
            // titleCard("Hello1", "This sample design card", false),
            // titleCard("Hello2", "This sample design card", true),
            // titleCard("Hello3", "This sample design card", false),
            // titleCard("Hello4", "This sample design card", false),
            // titleCard("Hello5", "This sample design card", true),
          ],
        ),
      ),
    );
  }

  //External Widgets for current class also make it private widgets
  Widget customText() {
    return Text("Hello world");
  }
}

//global card and reuseable
Widget titleCard(String title, description, bool isCompleted, DateTime date) {
  return Card(
    elevation: 4,
    margin: const EdgeInsets.only(bottom: 15),

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

    child: Padding(
      padding: const EdgeInsets.all(15),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Checkbox(
            value: isCompleted,

            onChanged: (value) {
              // controller
              //     .toggleComplete(task);
            },
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  description,

                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    const Icon(
                      Icons.calendar_month,
                      size: 18,
                      color: Colors.blue,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      // "Date",
                      DateFormat('dd MMM yyyy').format(date),
                    ),
                  ],
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: () {
              // controller.softDelete(task);
            },

            icon: const Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
    ),
  );
}
