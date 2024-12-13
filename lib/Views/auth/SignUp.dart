import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/auth/Login.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:google_fonts/google_fonts.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Sign Up",
                    style: GoogleFonts.nunitoSans(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      height: 47.74 /
                          35, // Line-height equivalent (lineHeight / fontSize)
                    ),
                  )),
                  SizedBox(height: 30),

                  // First Name TextField
                  Utils().buildTextField('First Name', _firstNameController),

                  // Last Name TextField
                  Utils().buildTextField('Last Name', _lastNameController),

                  // Email TextField
                  Utils().buildTextField(
                      'Email', _emailController, TextInputType.emailAddress),

                  Utils().buildTextField(
                      'Phone Number', _phoneController, TextInputType.number),

                  // Password TextField
                  Utils().buildTextField(
                    'Password',
                    _passwordController,
                  ),

                  // Confirm Password TextField
                  Utils().buildTextField(
                    'Confirm Password',
                    _confirmPasswordController,
                  ),
                  SizedBox(height: 20),

                  // SignUp Button
                  SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator() // Show loader while signing up
                            : ElevatedButton(
                                onPressed: _onSignUpPressed,
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
                                  'Sign Up',
                                  style: GoogleFonts.nunitoSans(
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

                  SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("Already have an account? ",style: GoogleFonts.nunitoSans(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey
                        // Line-height equivalent (lineHeight / fontSize)
                      )

                        ,),
                      InkWell(
                        onTap: () {
                          Get.to(Login());
                        },
                        child:  Text(
                          "Sign In",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black
                            // Line-height equivalent (lineHeight / fontSize)
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Sign up button logic
  void _onSignUpPressed() {
    if (_formKey.currentState!.validate()) {
      // Perform sign up action, for example, store the data or call an API

      authController.register(
        _firstNameController.text,
        _lastNameController.text,
        _emailController.text,
        _passwordController.text,
      );

      Utils.saveString("name", "${_firstNameController.text} ${_lastNameController.text.toString()}");
    }
  }
}
