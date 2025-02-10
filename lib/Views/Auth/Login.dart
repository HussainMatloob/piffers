import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/Auth/ForgotPassworsd.dart';
import 'package:piffers/Views/Auth/SignUp.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import '../Utils/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
        body: Stack(
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
              top: 120,
              right: 20,
              child: Center(
                child: Text(
                  "Sign In",
                  style: GoogleFonts.nunitoSans(
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Foreground content below "Sign In"
            Positioned(
              top: 230, // Position below the "Sign In" text
              left: 16,
              right: 16,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Email TextField
                    Utils().buildTextField(
                      "Email/Phone Number",
                      _emailController,
                    ),
                    const SizedBox(height: 20),

                    // Password TextField
                    Utils().buildTextField(
                      "Password",
                      _passwordController,
                    ),
                    const SizedBox(height: 40),

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
                    const SizedBox(height: 10),

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
                              backgroundColor: const Color.fromRGBO(
                                  124, 2, 16, 1.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.nunitoSans(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // OR Divider
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 120,
                          height: 1,
                          child: ColoredBox(color: Colors.grey),
                        ),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: Text(
                              "OR",
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            )),
                        SizedBox(
                          width: 120,
                          height: 1,
                          child: ColoredBox(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Social Media Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Utils().SocialMediaIcons("assets/png/f.png"),
                        Utils().SocialMediaIcons("assets/png/g.png"),
                        Utils().SocialMediaIcons("assets/png/t.png"),
                      ],
                    ),
                    const SizedBox(height: 80),

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
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 16,
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
    );
  }
}
