import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  // final ImagePicker _picker = ImagePicker();
  // Use MediaQuery to get screen width and height

  Widget buildSlideContent(BuildContext context, Map<String, String> slide) {
    // Access screen width and height using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.1, // 10% of the screen width
        right: screenWidth * 0.1, // 10% of the screen width
        top: screenHeight * 0.1, // 10% of the screen height
      ),
      child: Card(
        margin: EdgeInsets.only(bottom: screenHeight * 0.05),
        // 20% of the screen height
        color: Colors.white,
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                slide['image']!,
                fit: BoxFit.fill,
                height: screenHeight *
                    0.35, // 35% of the screen height for the image
              ),
              const SizedBox(height: 20.0),
              Text(
                slide['title']!,
                style: GoogleFonts.nunitoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10.0),
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.07),
                // 7% of the screen width for padding
                child: Text(
                  slide['description']!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      [TextInputType? inputType, bool obscureText = false]) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.nunitoSans(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            keyboardType: inputType ?? TextInputType.text,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white), // Text color set to white
            decoration: InputDecoration(
              contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white), // Default border color
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2), // Focused border color
              ),
              fillColor: Colors.transparent,
              filled: true,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your $label';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }







  Widget buildSearchField(TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15), // Circular border

          ),
          filled: true,
          fillColor: Colors.grey[200],
          hintText: 'Search...',
          // Placeholder text
          hintStyle: GoogleFonts.nunitoSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.grey[900],
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Define search action here
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a search term';
          }
          return null;
        },
      ),
    );
  }

  Widget SocialMediaIcons(String image) {
    return Container(
      width: 60, // Set width of the icon container
      height: 60, // Set height of the icon container
      decoration: BoxDecoration(
        color: Colors.white,
        // Background color of the container
        borderRadius: BorderRadius.circular(15),
        shape: BoxShape.rectangle,
        // Rounded corners
        border: Border.all(
          color: Colors.white, // Border color
          width: 2.0, // Border width
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 10, // Blur radius
            offset: const Offset(0, 5), // Shadow offset
          ),
        ],
      ),
      child: Center(
        child: Image.asset(
          image,
          fit: BoxFit.cover,
          width: 30, // Adjust image width
          height: 30, // Adjust image height
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.error,
              color: Colors.red,
              size: 30,
            );
          },
        ),
      ),
    );
  }

  Widget RoundedButton({
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = Colors.blueAccent,
    Color textColor = Colors.white,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        elevation: 5, // Button elevation
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor, // Button text color
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  static Widget imageWithTitle({
    required String imagePath,
    required String title,
    double imageSize = 40.0,
    TextStyle? textStyle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          imagePath,
          height: imageSize,
          width: imageSize,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8), // Space between image and title
        Text(
          title,
          style: textStyle ?? const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget buildCategoryItem(String imagePath) {
    return Column(
      children: [
        Container(
          child: Center(
              child: Image.asset(
            imagePath, // Path to your SVG file
            width: 100.0,
            height: 100.0,
          )),
        ),
      ],
    );
  }

  // Save a string value (e.g., token) in SharedPreferences
  static Future<void> saveString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  // Retrieve a string value (e.g., token) from SharedPreferences
  static Future<String?> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save a boolean value (e.g., isLoggedIn flag) in SharedPreferences
  static Future<void> saveBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  // Retrieve a boolean value (e.g., isLoggedIn flag) from SharedPreferences
  static Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  // Save a double value (e.g., balance or rating) in SharedPreferences
  static Future<void> saveDouble(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  // Retrieve a double value from SharedPreferences
  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  // Save an integer value (e.g., user ID) in SharedPreferences
  static Future<void> saveInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  // Retrieve an integer value from SharedPreferences
  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Remove an item from SharedPreferences
  static Future<void> remove(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  // Clear all data in SharedPreferences
  static Future<void> clear() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
