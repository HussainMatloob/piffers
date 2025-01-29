import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/BottomNav/Bottom_navbar.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/onBoardingScreen/OnboardingScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Check token and decide navigation
    Future.delayed(Duration(seconds: 2), () async {
      String? token = await Utils.getString('token'); // Fetch the token using your method

      print(" ++++++++++++++++++++  TOKEN IS : ${token.toString()} ++++++++++++++++++++++++++++++");
      if (token != null && token.isNotEmpty) {
        // If token exists, navigate to the BottomNavbar
        Get.offAll(() => BottomNavbar());
      } else {
        // If no token, navigate to the OnboardingScreen
        Get.offAll(() => OnboardingScreen());
      }
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Simple loading spinner
      ),
    );
  }
}
