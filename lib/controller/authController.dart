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
    // Future.delayed(const Duration(seconds: 5), () {
    //   Get.offAllNamed('/login');
    //   print('3 second has passed.'); // Prints after 1 second.
    // });

      // 2. Initialize the Rx variable with the current user state
    firebaseUser = Rx<User?>(_auth.currentUser);

    // 3. Bind the Rx variable to the actual Firebase stream
    firebaseUser.bindStream(_auth.authStateChanges());

    // 4. Ever listens to every change of firebaseUser and calls the worker function
    ever(firebaseUser, _setInitialScreen);
    // loadDemoTasks();
    streamTasks();
    super.onInit();
  }


 // 5. This worker function automatically routes the user based on login status
  void _setInitialScreen(User? user) {
    if (user == null) {
      print("User is signed out. Routing to login.");
      Get.offAllNamed('/login');
    } else {
      print("User is signed in: ${user.email}. Routing to home.");
      // Initialize task streaming only after a valid user is present
      streamTasks(); 
      Get.offAllNamed('/home'); // Corrected string escape path '\home' to '/home'
    }
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 1. Declare your RxList of TaskModels
  // final RxList<TaskModel> tasks = <TaskModel>[].obs;

  // A loading indicator state for your UI
  // final RxBool isLoading = false.obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Start listening to Firestore as soon as the controller initializes
  //   streamTasks();
  // }

  // 2. Stream data from Firebase and automatically convert it to your RxList
  void streamTasks() {
    isLoading.value = true;

    _firestore
        .collection('tasks')
        .orderBy("id", descending: true)
        .snapshots()
        .listen(
          (QuerySnapshot snapshot) {
            // Convert the Firestore documents into TaskModel objects
            final List<TaskModel> fetchedTasks = snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;

              // If you have a factory constructor TaskModel.fromMap, use that instead:
              // return TaskModel.fromMap(data);

              return TaskModel.fromMap(data, documentId: doc.id);
            }).toList();

            // 3. Assign the new data to your GetX RxList
            tasks.assignAll(fetchedTasks);
            isLoading.value = false;
          },
          onError: (error) {
            print("❌ Error fetching tasks: $error");
            isLoading.value = false;
          },
        );
  }

  void toggleComplete(TaskModel task, bool? value) {
    print("start.................");
    _firestore.collection("tasks").doc(task.id).update({
      "isCompleted": value,
      "taskDate": DateTime.now(),
    });
    print("process");
  }
}
