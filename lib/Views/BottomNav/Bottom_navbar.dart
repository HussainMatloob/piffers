import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:piffers/Views/BottomNav/LocateResponder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/Screens/MapViewScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Screens/InboxScreen.dart';
import '../Screens/KidsTrackingScreen.dart';
import '../Screens/NewPlaceScreen.dart';
import '../Screens/PetTrackingScreen.dart';
import '../Screens/QuotesRequestScreen.dart';
import '../Screens/WeatherScreen.dart';

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _selectedIndex = 0; // Index to track the selected tab

  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  // List of pages corresponding to each tab
  final List<Widget> _pages = [
    LocateResponder(),
    QuoteRequestScreen (),
    PetTrackingScreen(),
    InboxScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex], // Display the selected page
        bottomNavigationBar: SnakeNavigationBar.color(
          height: 60,
          shape: RoundedRectangleBorder(borderRadius: _borderRadius),
          backgroundColor: Colors.white, // Background color of the navigation bar
          selectedLabelStyle: GoogleFonts.inknutAntiqua(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            height: 1.35,
            textStyle: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.red, // Selected label color set to red
            ),
          ),
          unselectedLabelStyle: GoogleFonts.inknutAntiqua(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            height: 1.35,
            textStyle: const TextStyle(
              decoration: TextDecoration.none, // No underline for unselected labels
              color: Colors.black, // Unselected label color (default black)
            ),
          ),
          snakeViewColor: Colors.red, // Snake indicator color
          selectedItemColor: Colors.red, // Selected icon color set to red
          unselectedItemColor: Colors.black, // Unselected icon color set to black
          showSelectedLabels: true,
          showUnselectedLabels: true
          ,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/home.svg',
                height: 30,
                width: 30,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/watchme.svg',
                height: 30,
                width: 30,
              ),
              label: "Watch me",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/premiume.svg',
                height: 30,
                width: 30,
              ),
              label: "Premium",
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svg/more.svg',
                height: 30,
                width: 30,
              ),
              label: "More",
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index; // Update the selected index
            });
          },
        ),

      ),
    );
  }
}
