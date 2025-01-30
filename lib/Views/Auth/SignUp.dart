import 'package:flutter/material.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/Auth/Login.dart';
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
            Positioned(
              top: 120,
              right: 20,
              child: Text(
                "Sign Up",
                style: GoogleFonts.nunitoSans(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  height: 47.74 / 35,
                  // Line-height equivalent (lineHeight / fontSize)
                  color: Colors.white, // Set text color to white
                ),
              ),
            ),
            // Foreground content wrapped in SingleChildScrollView to allow scrolling
            Padding(
              padding: const EdgeInsets.all(50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 180),
                    // Adjust height for the space left by the "Sign Up" text

                    // First Name TextField
                    Utils().buildTextField('First Name', _firstNameController),

                    // Last Name TextField
                    Utils().buildTextField('Last Name', _lastNameController),

                    // Email TextField
                    Utils().buildTextField(
                        'Email', _emailController, TextInputType.emailAddress),

                    Utils().buildTextField(
                        'Phone Number', _phoneController, TextInputType.number),

                    // Utils().buildPhoneNumberField(
                    //   'Phone Number',
                    //   _phoneController,
                    //       (countryCode) {
                    //     selectedCountryCode = countryCode;
                    //     print('Selected Country Code: $selectedCountryCode');
                    //   },
                    // ),

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
                          print(
                              "Checking isLoading: ${authController.isLoading.value}");

                          if (authController == null ||
                              authController.isLoading == null) {
                            return const CircularProgressIndicator(); // Show loader if authController or isLoading is null
                          }

                          return authController.isLoading.value
                              ? const CircularProgressIndicator() // Show loader while signing up
                              : ElevatedButton(
                                  onPressed: () {
                                    if (_firstNameController.text.isNotEmpty &&
                                        _lastNameController.text.isNotEmpty &&
                                        _emailController.text.isNotEmpty &&
                                        _passwordController.text.isNotEmpty &&
                                        _confirmPasswordController
                                            .text.isNotEmpty) {
                                      print("Form validated successfully.");

                                      // Perform sign up action, for example, store the data or call an API
                                      print("Calling authController.register");
                                      authController.register(
                                        _firstNameController.text ?? "",
                                        _lastNameController.text ?? "",
                                        _emailController.text ?? "",
                                        _passwordController.text ?? "",

                                        // '$_selectedCountryCode${_phoneNumberController.text.trim()
                                      );

                                      // Utils.saveString("name",
                                      //     "${_firstNameController.text ?? ""} ${_lastNameController.text ?? ""}");
                                      print("User registered successfully.");
                                    } else {

                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromRGBO(124, 2, 16, 1.0),
                                    // Set the custom RGB color for the button
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 100, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign Up',
                                    style: GoogleFonts.nunitoSans(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                );
                        }),
                      ),
                    ),

                    SizedBox(height: 30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: GoogleFonts.nunitoSans(
                              fontSize: 13,
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
                                fontSize: 16,
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
