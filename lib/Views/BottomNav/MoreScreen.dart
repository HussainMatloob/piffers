import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/Utils/utils.dart';

class MoreScreen extends StatelessWidget {

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More",style: GoogleFonts.inknutAntiqua(
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),),
        backgroundColor: Colors.white, // Match the top bar color
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/png/background.png"),
            // Your background image
            fit: BoxFit.fitWidth,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Utils().buildSearchField(searchController),
              // Section: Private Eye
               Text(
                "PRIVATE EYE",
                style:GoogleFonts.inknutAntiqua(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryItem("Watch Over", "assets/png/cctv1.png"),
                  buildCategoryItem("Pet Tracking", "assets/png/dogtrack.png"),
                  buildCategoryItem(
                      "Kid Tracking", "assets/png/familymember.png"),
                ],
              ),
              Divider(color: Colors.white70, height: 30),

              // Section: Cameras
               Text(
                "CAMERAS",
                style:GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryItem(
                      "Camera Details", "assets/png/cctvcamera.png"),
                  buildCategoryItem(
                      "Field Activation", "assets/png/groupP.png"),
                ],
              ),
              Divider(color: Colors.white70, height: 30),

              // Section: Piffers Security Offering
               Text(
                "PIFFERS SECURITY OFFERING",
                style:GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryItem(
                      "Call Request", "assets/png/smartphone.png"),
                  buildCategoryItem(
                      "Client Query", "assets/png/customercare.png"),
                  buildCategoryItem("Quote Request", "assets/png/quotes.png"),
                ],
              ),
              Divider(color: Colors.white70, height: 30),

              // Section: Piffers Sedulous Offering
               Text(
                "FAMILY DETAILS",
                style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryItem("Add member", "assets/png/member.png"),
                  buildCategoryItem(
                      "Birthday Alerts", "assets/png/birthday.png"),
                  buildCategoryItem(
                      "Important Dates", "assets/png/calender.png"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 80, // Adjust size for icons
          height: 80,

          child: Center(
            child: Image.asset(
              imagePath, // Replace with your asset path
              fit: BoxFit.contain,
              width: 70,
              height: 70,
            ),
          ),
        ),
        SizedBox(height: 8), // Spacing between image and text
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inknutAntiqua(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.white
          ),
        ),
      ],
    );
  }
}
