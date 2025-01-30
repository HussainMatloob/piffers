import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Controllers/authcontroller.dart';
import '../Utils/utils.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey1 = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
      body: Stack(
        children: [
          // Background Image at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/png/authB.png",
              height: 250,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    size: 24,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Get.back();
                  },
                ),
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "Enter New Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child:  Text(
                        "Your new password must be difficult \n from previously used passwords",
                        style: TextStyle(color: Colors.white70, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Utils().buildPasswordField(
                      "Password",
                      _newPasswordController,
                      icon: Icons.lock,
                      borderColor: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Utils().buildPasswordField(
                      "Confirm Password",
                      _confirmPasswordController,
                      icon: Icons.lock,
                      borderColor: Colors.white,
                    ),
                    const SizedBox(height: 40),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : ElevatedButton(
                          onPressed: _onForgotPasswordPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7E2121),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 80, vertical: 8),
                            shape: const RoundedRectangleBorder(
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style:
                            TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onForgotPasswordPressed() async {
    if (_newPasswordController.text.isEmpty &&
        !_confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter a confirm password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    String? token = await Utils.getString("Token");
    String? email = await Utils.getString("email");

    if (_formKey1.currentState!.validate()) {
      String newPassword = _newPasswordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (newPassword == confirmPassword) {
        authController
            .resetPassword(
          _confirmPasswordController.text.trim(),
          _newPasswordController.text.trim(),
          token.toString(),
          email.toString(),
        )
            .then((_) {})
            .catchError((error) {
          Get.snackbar(
            'Error',
            'Failed to send password reset email. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
          );
        });
      }
    }
  }
}
