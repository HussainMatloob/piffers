import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piffers/Splash.dart';
import 'package:piffers/Views/BottomNav/AddResponder.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';
import 'package:piffers/Views/auth/ForgotPassworsd.dart';
import 'package:piffers/Views/auth/Login.dart';
import 'package:piffers/Views/auth/ResetPassword.dart';
import 'package:piffers/Views/auth/SignUp.dart';
import 'package:piffers/Views/onBoardingScreen/OnboardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  print('Connected to Firebase: ${app.name}');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/splash', // Initial route
      getPages: [
        GetPage(name: '/splash', page: () => SplashScreen()),
        GetPage(name: '/onboarding', page: () => OnboardingScreen()),
        GetPage(name: '/signup', page: () => const Signup()),
        GetPage(name: '/login', page: () => const Login()),
        GetPage(name: '/forgotpassword', page: () => const ForgotPassword()),
        GetPage(name: '/resetpassword', page: () => ResetPassword()),
        GetPage(name: '/addresponder', page: () => Addresponder()),
        GetPage(name: '/more', page: () => MoreScreen()),
        GetPage(name: '/responderlist', page: () => ResponderListScreen()),
      ],
    );
  }
}
