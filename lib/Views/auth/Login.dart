import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/BottomNav/Bottom_navbar.dart';
import 'package:piffers/Views/auth/ForgotPassworsd.dart';
import 'package:piffers/Views/auth/SignUp.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import '../Utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top:100),
                  child: Center(
                      child: Text(
                    "Sign In",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      height: 47.74 / 35, // Line-height equivalent (lineHeight / fontSize)
                    ),
                  )),
                ),
                SizedBox(height: 80),

                // Email TextField
                Utils().buildTextField(
                  "Email/Phone Number",
                  _emailController,
                ),
                // Password TextField
                Utils().buildTextField(
                  "Password",
                  _passwordController,
                ),
                const SizedBox(height: 40),
                InkWell(
                  child: const Center(
                      child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.grey),
                  )),
                  onTap: () {
                    Get.to(ForgotPassword());
                  },
                ),
                const SizedBox(height: 10),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Obx(() {
                      return authController.isLoading.value
                          ? CircularProgressIndicator() // Show a loader while signing in
                          : ElevatedButton(
                              onPressed: () {
                                // Trigger the login method from the AuthController
                                authController.login(
                                  _emailController.text,
                                  _passwordController.text,
                                );
                                print("Email is :   ${_emailController.text.toString()} and Password is : ${_passwordController.text.toString()}");
                              },
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
                              child:  Text(
                                'Sign In',
                                style:  GoogleFonts.nunitoSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                                  // Line-height equivalent (lineHeight / fontSize)
                                ),
                              ),
                            );
                    }),
                  ),
                ),

                const SizedBox(height: 30),

                const Padding(
                  padding:EdgeInsets.only(left: 10,right: 10),
                  child: Row(
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
                            style: TextStyle(fontSize: 18),
                          )),
                      SizedBox(
                        width: 120,
                        height: 1,
                        child: ColoredBox(color: Colors.grey),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 15),

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("don't have account? "),
                    InkWell(
                      onTap: () {
                        Get.to(Signup());
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Color.fromRGBO(7, 52, 91, 1), fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
