import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:piffers/Splash.dart';
import 'package:piffers/Views/BottomNav/AddResponder.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';
import 'package:piffers/Views/Auth/ForgotPassworsd.dart';
import 'package:piffers/Views/Auth/Login.dart';
import 'package:piffers/Views/Auth/ResetPassword.dart';
import 'package:piffers/Views/Auth/SignUp.dart';
import 'package:piffers/Views/onBoardingScreen/OnboardingScreen.dart';
import 'package:piffers/Views/Services/firebase_messaging_service.dart';
import 'Views/Controllers/notification_controller.dart';
import 'Views/Screens/NotificationListScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  FirebaseApp app = await Firebase.initializeApp();
  print('Connected to Firebase: ${app.name}');

  // Initialize GetX Controllers and Firebase Messaging Service
  Get.put(NotificationController());
  final firebaseMessagingService = FirebaseMessagingService();
  await firebaseMessagingService.initialize();

  // Subscribe to the 'responders' topic
  await FirebaseMessaging.instance.subscribeToTopic('responders');
  print('Subscribed to responders topic.');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PIFFERS SOS',
        initialRoute: '/splash',
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
          GetPage(
              name: '/notificationlist', page: () => NotificationListScreen()),
        ],
      ),
    );
  }
}
