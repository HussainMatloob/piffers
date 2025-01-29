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
      backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 300, left: 20, right: 20),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Mail Address Here',
                    style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Enter the email address associated \n with your account ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                if (!isEmailSent) ...[
                  // Email Input View
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      color: Colors.white, // Set text color to white
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintStyle: TextStyle(
                        color: Colors.white, // Hint text color
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey, // Set prefix icon color to grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.red, // Set border color to red
                        ),

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
                                      const Color.fromRGBO(126, 35, 35, 1),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 120, vertical: 10),
                                 shape: const RoundedRectangleBorder(),
                                ),
                                child: const Text(
                                   'Recover Password',
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
                    child: Text(
                      'Enter the OTP sent to your email',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  OtpTextField(
                    cursorColor: Colors.black, // Set cursor color to white
                    numberOfFields: 4,
                    fillColor: Colors.white, // Set background color to black
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    borderColor: Colors.white, // Remove default border color
                    onSubmit: _onVerifyOtpPressed, // Verify OTP
                    showFieldAsBox: true,
                    focusedBorderColor: Colors.white, // Change focus border color to white
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,// White text color for focused OTP fields
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black, // Change background color to black when focused
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // add rich text for resend OTP
                  RichText(
                    text: const TextSpan(
                      text: 'Didn\'t receive the OTP? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: 'Resend OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ],
            ),
          ),

          Positioned(
            top: 0,
            child: SizedBox(
              width: Get.width,
              child: Image.asset(
                "assets/png/authB.png", // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),

          // create row for back icon and text
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
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
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
      await authController.sendOtp(emailController.text.toString());
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
