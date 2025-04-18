import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/Auth/ForgotPassworsd.dart';
import 'package:piffers/Views/Auth/SignUp.dart';
import 'package:piffers/Views/Controllers/Authcontroller.dart';
import '../Utils/utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  final AuthController authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email and Password cannot be empty!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    authController.login(email, password);
    print("Email: $email, Password: $password");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height,
                  child: Stack(
                    children: [
                      // Background Image
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
                      // "Sign In" Text
                      Positioned(
                        top: 100.h,
                        right: 110.w,
                        child: Center(
                          child: Text(
                            "Sign In",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 45.sp,
                              fontWeight: FontWeight.w700,
                              height: 1.3.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Foreground content below "Sign In"
                      Positioned(
                        top: 210.h, // Position below the "Sign In" text
                        left: 16.w,
                        right: 16.w,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Email TextField
                              Utils().buildTextField(
                                "Email/Phone Number",
                                _emailController,
                              ),
                              SizedBox(height: 20.h),

                              // Password TextField
                              Utils().buildTextField(
                                "Password",
                                _passwordController,
                              ),
                              SizedBox(height: 40.h),

                              // Forgot Password
                              InkWell(
                                child: const Center(
                                    child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(color: Colors.white),
                                )),
                                onTap: () {
                                  Get.to(const ForgotPassword());
                                },
                              ),
                              SizedBox(height: 10.h),

                              // Login Button
                              SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Obx(() {
                                    return authController.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : ElevatedButton(
                                            onPressed: _handleLogin,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      124, 2, 16, 1.0),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 100.w,
                                                  vertical: 15.h),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                              ),
                                            ),
                                            child: Text(
                                              'Sign In',
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

                              // OR Divider
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 120.w,
                                    height: 1,
                                    child: const ColoredBox(color: Colors.grey),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(5.r),
                                      child: Text(
                                        "OR",
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            color: Colors.white),
                                      )),
                                  SizedBox(
                                    width: 120.w,
                                    height: 1.h,
                                    child:
                                        const ColoredBox(color: Colors.white),
                                  )
                                ],
                              ),
                              SizedBox(height: 15.h),

                              // Social Media Icons
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Utils().SocialMediaIcons("assets/png/f.png"),
                                  Utils().SocialMediaIcons("assets/png/g.png"),
                                  Utils().SocialMediaIcons("assets/png/t.png"),
                                ],
                              ),
                              SizedBox(height: 25.h),

                              // Sign Up Link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(const Signup());
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 16.sp,
                                      ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
