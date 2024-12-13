import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:piffers/Views/BottomNav/LocateResponder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';


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
    ResponderListScreen(),
    Center(child: Text("Private Eye")),
    Center(child: Text("View My Camera")),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _pages[_selectedIndex], // Display the selected page
        bottomNavigationBar: SnakeNavigationBar.color(
           height: 80,
          shape:  RoundedRectangleBorder(borderRadius: _borderRadius),
          // Set the background color
          backgroundColor: Colors.white ,
          selectedLabelStyle: GoogleFonts.inknutAntiqua(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            height: 1.35, // Equivalent to line-height: 14.85px
            textStyle: const TextStyle(
              decoration: TextDecoration.none,
              color: Colors.grey// No underline by default
            ),
          ),
          unselectedLabelStyle: GoogleFonts.inknutAntiqua(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            height: 1.35, // Equivalent to line-height: 14.85px
            textStyle: const TextStyle(
              decoration: TextDecoration.none, // No underline by default
            ),
          ),
          showUnselectedLabels: true,
          snakeShape: SnakeShape.indicator, // Snake shape around the selected tab
          snakeViewColor: Colors.black, // Color of the snake indicator
          // Define the navigation items
          items: [
             BottomNavigationBarItem(
              icon: Image.asset(
                'assets/png/moveloc.png', // Replace with your image path
                height: 35, // Adjust size as needed
                width: 35,
              ),
              label: "Locate Responder",
            ),
             BottomNavigationBarItem(
              icon:  Image.asset(
                'assets/png/trackloc.png', // Replace with your image path
                height: 35, // Adjust size as needed
                width: 35,
              ),
              label: "Piffers Responder",
            ),
            BottomNavigationBarItem(
              icon:  Image.asset(
                'assets/png/eyeicon.png', // Replace with your image path
                height: 35, // Adjust size as needed
                width: 35,
              ),
              label: "Private Eye",
            ),
             BottomNavigationBarItem(
              icon:  Image.asset(
                'assets/png/camera.png', // Replace with your image path
                height: 35, // Adjust size as needed
                width: 35,
              ),
              label: "View My Camera",
            ),
          ],
          currentIndex: _selectedIndex, // Set the selected index
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
