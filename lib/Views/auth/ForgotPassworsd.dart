import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/auth/ResetPassword.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthController authController = Get.put(AuthController());
  final emailController = TextEditingController();
  bool isEmailSent = false; // Track if email is sent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: Colors.white70,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Image(
                  image: AssetImage('assets/png/forget.jpg'),
                  height: 200,
                  width: double.infinity,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Please enter your email address. You will receive a code to verify your email and reset your password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                if (!isEmailSent) ...[
                  // Email Input View
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Enter Email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator() // Show loader while sending the email
                            : ElevatedButton(
                          onPressed: _onForgotPasswordPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color.fromRGBO(7, 52, 91, 1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Send OTP',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18),
                          ),
                        );
                      }),
                    ),
                  ),
                ] else ...<Widget>[
                  // OTP Input View
                  const Center(
                    child:  Text(
                      'Enter the OTP sent to your email',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(
                    numberOfFields: 4,
                    borderColor: const Color(0xFF512DA8),
                    onSubmit: _onVerifyOtpPressed, // Verify OTP
                  ),
                  const SizedBox(height: 20),

                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onForgotPasswordPressed() async {
    if (emailController.text.isEmpty ||
        !emailController.text.contains('@') ||
        !emailController.text.contains('.')) {
      Get.snackbar(
        'Error',
        'Please enter a valid email address',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      await authController.sendOtp(emailController.text.toString() );
      print("Forget Email : ${emailController.text.toString()}");
      Utils.saveString("forgetemail", emailController.text.toString());

      setState(() {
        isEmailSent = true; // Switch to OTP input view
      });
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _onVerifyOtpPressed(String otp) async {
    Utils.saveString("OTP", otp);
    print("Forget Email : ${otp.toString()}");

    Get.to(ResetPassword());
  }


}
