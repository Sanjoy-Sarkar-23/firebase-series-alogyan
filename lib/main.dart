import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_series/App.dart';
import 'package:firebase_series/controller/authController.dart';
import 'package:firebase_series/firebase_options.dart';
import 'package:firebase_series/model/TodoModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Get.put(AuthController()); // Register AuthController with GetX

  runApp(const MyApp());
}

Future<void> seedTasksToFirebase() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Using a WriteBatch to commit all documents at once
  final WriteBatch batch = firestore.batch();
  final CollectionReference tasksCollection = firestore.collection('tasks');

  // Your list of demo tasks
  final List<TaskModel> demoTasks = [
    TaskModel(
      id: "1",
      title: "Learn Flutter Widgets",
      description: "Practice Row, Column, Stack and Container",
      taskDate: DateTime(2026, 5, 10),
      createdAt: DateTime.now(),
      // Assuming your model defaults to false, we explicitly set it here if missing
      isCompleted: false,
    ),
    TaskModel(
      id: "2",
      title: "Complete GetX Tutorial",
      description: "Understand Obx and Controller lifecycle",
      taskDate: DateTime(2026, 5, 11),
      createdAt: DateTime.now(),
      isCompleted: true,
    ),
    TaskModel(
      id: "3",
      title: "Build Login Screen",
      description: "Create responsive login UI",
      taskDate: DateTime(2026, 5, 12),
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: "4",
      title: "Practice Firebase Auth",
      description: "Email and password login practice",
      taskDate: DateTime(2026, 5, 13),
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: "5",
      title: "Firestore CRUD",
      description: "Add update delete fetch practice",
      taskDate: DateTime(2026, 5, 14),
      createdAt: DateTime.now(),
      isCompleted: true,
    ),
    TaskModel(
      id: "6",
      title: "Animation Practice",
      description: "Learn Hero and page transition",
      taskDate: DateTime(2026, 5, 15),
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: "7",
      title: "REST API Integration",
      description: "Fetch API using http package",
      taskDate: DateTime(2026, 5, 16),
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: "8",
      title: "Deploy Flutter Web",
      description: "Deploy project to Firebase hosting",
      taskDate: DateTime(2026, 5, 17),
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: "9",
      title: "Learn Clean Architecture",
      description: "Study repository pattern",
      taskDate: DateTime(2026, 5, 18),
      createdAt: DateTime.now(),
      isCompleted: true,
    ),
    TaskModel(
      id: "10",
      title: "Flutter Interview Preparation",
      description: "Practice important interview questions",
      taskDate: DateTime(2026, 5, 19),
      createdAt: DateTime.now(),
      isCompleted: false,
    ),
  ];

  for (var task in demoTasks) {
    // We use the task.id as the Firestore Document ID
    DocumentReference docRef = tasksCollection.doc(task.id);

    // Note: If your TaskModel has a .toMap() or .toJson() method,
    // you can replace this map with: batch.set(docRef, task.toMap());
    batch.set(docRef, {
      'id': task.id,
      'title': task.title,
      'description': task.description,
      // Firestore automatically handles DateTime objects by converting them to Timestamps
      'taskDate': task.taskDate,
      'createdAt': task.createdAt,
      'isCompleted': task.isCompleted,
    });
  }

  try {
    // Commit the batch
    await batch.commit();
    print("✅ Successfully seeded ${demoTasks.length} tasks to Firebase!");
  } catch (e) {
    print("❌ Error seeding data to Firebase: $e");
  }
}
