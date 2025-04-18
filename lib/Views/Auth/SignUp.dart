import 'package:flutter/material.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/Auth/Login.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Controllers/Authcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'VarifyOTPScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String selectedCountryCode = '+92'; // Default to US

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
        // Set blue900 background color
        body: Stack(
          children: [
            // Background Image
            Positioned(
              top: 0,
              child: SizedBox(
                width: Get.width,
                child: Image.asset(
                  "assets/png/authB.png", // Same background image as in Login
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Sign Up Text positioned

            // Foreground content wrapped in SingleChildScrollView to allow scrolling
            Padding(
              padding: EdgeInsets.all(30.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 65.h),
                    Text(
                      "Sign Up",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 45.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 70.h),
                    Utils().buildTextField('First Name', _firstNameController),
                    Utils().buildTextField('Last Name', _lastNameController),
                    Utils().buildTextField(
                        'Email', _emailController, TextInputType.emailAddress),
                    Utils().buildTextField(
                        'Phone Number', _phoneController, TextInputType.number),
                    Utils().buildTextField(
                      'Password',
                      _passwordController,
                    ),
                    Utils().buildTextField(
                      'Confirm Password',
                      _confirmPasswordController,
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Obx(() {
                          print(
                              "Checking isLoading: ${authController.isLoading.value}");

                          if (authController.isLoading.value) {
                            return const CircularProgressIndicator();
                          }

                          return ElevatedButton(
                            onPressed: () async {
                              // Trim all input fields to avoid spaces issues
                              String firstName =
                                  _firstNameController.text.trim();
                              String lastName = _lastNameController.text.trim();
                              String email = _emailController.text.trim();
                              String password = _passwordController.text.trim();
                              String confirmPassword =
                                  _confirmPasswordController.text.trim();

                              // Validate required fields
                              if (firstName.isEmpty ||
                                  lastName.isEmpty ||
                                  email.isEmpty ||
                                  password.isEmpty ||
                                  confirmPassword.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'All fields are required.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              // Validate password confirmation
                              if (password != confirmPassword) {
                                Get.snackbar(
                                  'Error',
                                  'Passwords do not match.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              print(
                                  "Form validated successfully. Registering user...");

                              // Call the register function
                              await authController.register(
                                firstName,
                                lastName,
                                email,
                                password,
                              );

                              // Save email for OTP verification
                              Utils.saveString("email", email);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(124, 2, 16, 1.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 100.w, vertical: 15.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Sign Up',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(Login());
                          },
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.nunitoSans(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
