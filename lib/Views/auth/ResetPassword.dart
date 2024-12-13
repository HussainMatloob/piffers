import 'package:flutter/material.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:get/get.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Reset Password'),
        backgroundColor: Colors.white70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage("assets/png/reset.png"),
                width: double.infinity,
                height: 200,
              ),
              SizedBox(height: 20),
              // New Password Field
              Utils().buildTextField(
                  "Enter your new password below:", _newPasswordController),
              SizedBox(height: 20),
              Utils().buildTextField(
                  "Confirm Password:", _confirmPasswordController),

              SizedBox(height: 20),

              // Reset Button
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: Obx(() {
                    return authController.isLoading.value
                        ? const CircularProgressIndicator() // Show loader while sending the reset request
                        : ElevatedButton(
                            onPressed: _onForgotPasswordPressed,
                            // Trigger the reset password action
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(7, 52, 91, 1),
                              // Blue background
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                          );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onForgotPasswordPressed() async {
    if (_newPasswordController.text.isEmpty &&
        !_confirmPasswordController.text.isEmpty) {
      // Show error snackbar if email is invalid
      Get.snackbar(
        'Error',
        'Please enter a confirm password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    String? token=await  Utils.getString("OTP");
    String? email=await  Utils.getString("email");
    print("=========================TOKEN : ${token} ===================================");
    print("=========================TOKEN : ${email} ===================================");

    // Call the method to send the reset password email
    if (_formKey1.currentState!.validate()) {
      String newPassword = _newPasswordController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (newPassword == confirmPassword) {
        authController
            .resetPassword(
            _confirmPasswordController.text.trim(),_newPasswordController.text.trim(), token.toString(),email.toString())
            .then((_) {
          // After sending the password reset link, navigate to the ResetPassword screen
          // Get.to(ResetPasswordScreen(token: 'your_token_here')); // Make sure to pass the token
        }).catchError((error) {
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
