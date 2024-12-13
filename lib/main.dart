import 'package:flutter/material.dart';
import 'package:piffers/Splash.dart';
import 'package:piffers/Views/BottomNav/AddResponder.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';
import 'package:piffers/Views/auth/ForgotPassworsd.dart';
import 'package:piffers/Views/auth/Login.dart';
import 'package:piffers/Views/auth/ResetPassword.dart';
import 'package:piffers/Views/auth/SignUp.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/onBoardingScreen/OnboardingScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      initialRoute: '/splash',  // The route to be shown when the app starts
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()), // New SplashScreen
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),  // Route for OnboardingScreen
        GetPage(name: '/signup', page: () => Signup()),  // Route for SignUpScreen
        GetPage(name: '/login', page: () => Login()),     // Route for HomeScreen (optional)
        GetPage(name: '/forgotpassword', page: () => ForgotPassword()),     // Route for HomeScreen (optional)
        GetPage(name: '/resetpassword', page: () => ResetPassword()),     // Route for HomeScreen (optional)
        GetPage(name: '/addresponder', page: () =>Addresponder()),     // Route for HomeScreen (optional)
        GetPage(name: '/more', page: () =>MoreScreen()),     // Route for HomeScreen (optional)
        GetPage(name: '/responderlist', page: () =>ResponderListScreen()),     // Route for HomeScreen (optional)
      ],
    );
  }
}


