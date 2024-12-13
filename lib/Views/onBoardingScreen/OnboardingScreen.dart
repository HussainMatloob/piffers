import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Utils/utils.dart'; // Add GetX for navigation.

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
                  return Utils().buildSlideContent(slides[index]);
                },
              ),
            ),

            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300), // Smooth animation
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  height: 10.0,
                  width: currentPage == index ? 20.0 : 10.0, // Wider width for selected
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? const Color.fromRGBO(7, 52, 91, 1)
                        : Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0), // Rounded edges
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Skip and Next buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip button

                  InkWell(
                    onTap: (){
                      Get.offNamed('/signup');
                    },
                    child: const Text("Skip", style: TextStyle(fontSize: 16,color: Colors.grey)),

                  ),

                  // Next button
                  ElevatedButton(
                    onPressed: () {
                      if (currentPage < slides.length - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      }
                      else {
                        Get.offNamed('/signup'); // Navigate to Login Screen
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(7, 52, 91, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                    ),
                    child: const Text("Next", style: TextStyle(fontSize: 16,color: Colors.white), ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build slide content
  // Widget _buildSlideContent(Map<String, String> slide) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 45.0,right: 45.0,top: 70),
  //     child: Card(
  //       margin: EdgeInsets.only(bottom: 130),
  //       color: Colors.white,
  //       elevation: 8.0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30.0),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Image.asset(
  //             slide['image']!,
  //             fit: BoxFit.fill,
  //             height: 350.0,
  //           ),
  //           const SizedBox(height: 20.0),
  //           Text(
  //             slide['title']!,
  //             style: const TextStyle(
  //               fontSize: 24.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //           const SizedBox(height: 10.0),
  //           Padding(
  //             padding: EdgeInsets.all(25),
  //             child: Text(
  //               slide['description']!,
  //               textAlign: TextAlign.center,
  //               style: const TextStyle(fontSize: 16.0, color: Colors.black),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
