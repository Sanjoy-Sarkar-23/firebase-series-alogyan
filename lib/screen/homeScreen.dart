import 'package:firebase_series/controller/authController.dart';
import 'package:firebase_series/model/TodoModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final AuthController ac = Get.find();
  @override
  Widget build(BuildContext context) {
    print("rebuild");
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
            Expanded(
              child: Obx(() {
                if (ac.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (ac.tasks.isEmpty) {
                  return const Center(child: Text("No tasks found."));
                }
                return ListView.builder(
                  itemCount: ac.tasks.length,

                  itemBuilder: (context, index) {
                    final task = ac.tasks[index];
                    return titleCard(task);
                  },
                );
              }),
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

  Widget titleCard(TaskModel task) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      child: Padding(
        padding: const EdgeInsets.all(15),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            //this check box update task
            Checkbox(
              value: task.isCompleted,

              onChanged: (value) {
                // This main functions  for updating task
                ac.toggleComplete(task ,value);
              },
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    task.title,

                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,

                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    task.description,

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
                        DateFormat('dd MMM yyyy').format(task.createdAt),
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
}

//global card and reuseable
