import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/Auth/ResetPassword.dart';
import 'package:piffers/Views/Controllers/Authcontroller.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  AuthController authController = Get.put(AuthController());
  final emailController = TextEditingController();
  bool isEmailSent = false; // Track if email is sent

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 300.h, left: 20.w, right: 20.w),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Mail Address Here',
                    style: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Enter the email address associated \n with your account ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
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

                  SizedBox(height: 40.h),
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 90.w, vertical: 10.h),
                                  shape: const RoundedRectangleBorder(),
                                ),
                                child: Text(
                                  'Recover Password',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18.sp),
                                ),
                              );
                      }),
                    ),
                  ),
                ] else ...<Widget>[
                  // OTP Input View
                  Center(
                    child: Text(
                      'Enter the OTP sent to your email',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  OtpTextField(
                    cursorColor: Colors.black, // Set cursor color to white
                    numberOfFields: 4,
                    fillColor: Colors.white, // Set background color to black
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    borderColor: Colors.white, // Remove default border color
                    onSubmit: _onVerifyOtpPressed, // Verify OTP
                    showFieldAsBox: true,
                    focusedBorderColor:
                        Colors.white, // Change focus border color to white
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 24, // White text color for focused OTP fields
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors
                          .black, // Change background color to black when focused
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // add rich text for resend OTP
                  RichText(
                    text: TextSpan(
                      text: 'Didn\'t receive the OTP? ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                      children: [
                        TextSpan(
                          text: 'Resend OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
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
            top: 40.h,
            left: 20.w,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 24.sp,
                  ),
                  color: Colors.white,
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 30.sp,
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
      Get.snackbar('Error', 'Please enter a valid email address',
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
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
