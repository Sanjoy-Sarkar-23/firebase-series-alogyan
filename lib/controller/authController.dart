import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_series/model/TodoModel.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance; // firebase-auth means login
  final FirebaseFirestore _db =
      FirebaseFirestore.instance; // firebase firestore means db data store

  Rx<User?> firebaseUser = Rx<User?>(null); // user model means schema
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed('/login');
      print('3 second has passed.'); // Prints after 1 second.
    });
    loadDemoTasks();
    super.onInit();
  }

  // 🔐 SIGN UP
  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Save user in Firestore
      await _db.collection("users").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
      });

      Get.snackbar("Success", "Account created");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 🔓 LOGIN
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      await _auth.signInWithEmailAndPassword(email: email, password: password);
      print("User logged in: ${_auth.currentUser!.email}");
      Get.snackbar("Success", "Logged in");
      Get.offAllNamed('\home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
  }

  // 📄 GET USER DATA
  Future<Map<String, dynamic>?> getUserData() async {
    if (_auth.currentUser == null) return null;

    DocumentSnapshot doc = await _db
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get();

    return doc.data() as Map<String, dynamic>?;
  }

  //Todo Demo Data
  RxList<TaskModel> tasks = <TaskModel>[].obs;

  void loadDemoTasks() {
    tasks.assignAll([
      TaskModel(
        id: "1",
        title: "Learn Flutter Widgets",
        description: "Practice Row, Column, Stack and Container",
        taskDate: DateTime(2026, 5, 10),
        createdAt: DateTime.now(),
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
      ),

      TaskModel(
        id: "4",
        title: "Practice Firebase Auth",
        description: "Email and password login practice",
        taskDate: DateTime(2026, 5, 13),
        createdAt: DateTime.now(),
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
      ),

      TaskModel(
        id: "7",
        title: "REST API Integration",
        description: "Fetch API using http package",
        taskDate: DateTime(2026, 5, 16),
        createdAt: DateTime.now(),
      ),

      TaskModel(
        id: "8",
        title: "Deploy Flutter Web",
        description: "Deploy project to Firebase hosting",
        taskDate: DateTime(2026, 5, 17),
        createdAt: DateTime.now(),
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
      ),
    ]);
  }
}
