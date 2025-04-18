import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Utils/utils.dart'; // Add GetX for navigation.
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  // List of onboarding slides
  final List<Map<String, String>> slides = [
    {
      "title": "Emergency Response",
      "description":
          "Emergency Response at Your Fingertips.Click the SOS button to alert responders and share your location.Stay safe, anywhere, anytime.",
      "image": 'assets/png/first.png',
    },
    {
      "title": "Keep Loved Ones Close",
      "description":
          "Add family members, friends, or caregivers as responders.Receive alerts and track their location in real-time.",
      "image": 'assets/png/second.png',
    },
    {
      "title": "Stay Safe, Stay Connected",
      "description":
          "With our SOS alarm app,you're never alone in an emergency.Add responders and keep loved ones safe.",
      "image": 'assets/png/third.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // PageView for slides
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: slides.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Utils().buildSlideContent(context, slides[index]);
                },
              ),
            ),

            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (index) => AnimatedContainer(
                  duration:
                      const Duration(milliseconds: 300), // Smooth animation
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  height: 10.h,
                  width: currentPage == index
                      ? 20.0
                      : 10.0, // Wider width for selected
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color.fromRGBO(7, 52, 91, 1)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.r), // Rounded edges
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Skip and Next buttons
            Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button

                  InkWell(
                    onTap: () {
                      Get.offNamed('/login');
                    },
                    child: Text("Skip",
                        style: TextStyle(fontSize: 16.sp, color: Colors.grey)),
                  ),

                  // Next button
                  ElevatedButton(
                    onPressed: () {
                      if (currentPage < slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Get.offNamed('/login'); // Navigate to Login Screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(7, 52, 91, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 30.w,
                        vertical: 10.h,
                      ),
                    ),
                    child: Text(
                      "Next",
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
