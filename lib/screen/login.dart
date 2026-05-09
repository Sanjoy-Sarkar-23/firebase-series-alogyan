import 'package:firebase_series/controller/authController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final AuthController authController =
      Get.find(); // Get the AuthController instance

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 380,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // 🔹 Logo
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.psychology, size: 32),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Cerebral",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  "Unlock your second brain",
                  style: TextStyle(color: Colors.grey.shade500),
                ),

                const SizedBox(height: 24),

                // 🔹 Email
                buildField("EMAIL ADDRESS", "name@domain.com", emailController),

                const SizedBox(height: 16),

                // 🔹 Password
                buildField(
                  "PASSWORD",
                  "••••••••",
                  passController,
                  obscure: true,
                ),

                const SizedBox(height: 16),

                // 🔹 Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => authController.login(
                      emailController.text,
                      passController.text,
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text("Sign In"),
                  ),
                ),

                const SizedBox(height: 24),

                // 🔹 Divider
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text("OR CONTINUE WITH"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 16),

                // 🔹 Social Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.g_mobiledata),
                        label: const Text("Google"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.apple),
                        label: const Text("Apple"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔹 Footer
                const Text(
                  "New to Cerebral? Create an account",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                Text(
                  "Encrypted with 256-bit AES. Your thoughts are private.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔁 Reusable TextField
  Widget buildField(
    String label,
    String hint,
    inputController, {
    bool obscure = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        TextField(
          obscureText: obscure,
          controller: inputController,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            // fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
