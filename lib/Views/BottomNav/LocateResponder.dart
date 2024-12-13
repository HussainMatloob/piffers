import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';
import 'package:piffers/Views/PdfScreen.dart';
import 'package:piffers/Views/Utils/Timer.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/controllers/Uicontroller.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/controllers/pdfcontroller.dart';
import 'package:url_launcher/url_launcher.dart';

class LocateResponder extends StatefulWidget {
  @override
  _LocateResponderState createState() => _LocateResponderState();
}

class _LocateResponderState extends State<LocateResponder> {
  // Track the selected index for bottom navigation
  final AuthController authController = Get.put(AuthController());
  final UIController uiController = Get.put(UIController());
  final PdfController pdfController =
      Get.put(PdfController()); // Create an instance of PdfController

  String _fullName = "";

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  // Load full name from SharedPreferences
  Future<void> _loadFullName() async {
    String fullName = await fetchName();
    setState(() {
      _fullName = fullName;
    });
  }

  Future<String> fetchName() async {
    String? name = await Utils.getString("firstname");
    String? name1 = await Utils.getString("lastname");
// Concatenate first name and last name, or use a default value if either is null
    String fullName = '${name ?? ""} ${name1 ?? ""}'.trim();

    print("First name: ${name} and Last name: ${name1}");
    // Return the full name (default value if both are null)
    return fullName.isEmpty ? "Armughan Tallat Khan" : fullName;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            "HOME",
            style: GoogleFonts.inknutAntiqua(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
          actions: [
            IconButton(
              icon: Image.asset('assets/png/logo1.png'),
              onPressed: () {
                // Handle notification action
              },
            ),
            IconButton(
              icon: Image.asset('assets/png/logo2.png'),
              onPressed: () {
                // Handle settings action
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(161, 44, 44, 1),
                      Color.fromRGBO(153, 42, 42, 1),
                      Color.fromRGBO(59, 16, 16, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    // Centered Header Content

                    // Profile Image in Bottom Left
                    Positioned(
                      bottom: 0,
                      left: 10,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                            'assets/png/profile.png'), // Example image
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/user.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'My Account',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Home tap
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/transA.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Trasaction Activity',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/managment.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Management',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/cart.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Apply for new products',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/setting.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Settings',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/info.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Information and help',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/services.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Services Request',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                },
              ),
              ListTile(
                leading: SvgPicture.asset(
                  'assets/svg/logout.svg', // Path to your SVG file
                  width: 40.0,
                  height: 40.0,
                ),
                title: Text(
                  'Logout',
                  style: GoogleFonts.inknutAntiqua(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  // Handle Settings tap
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Logout'),
                        content: Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Perform logout operation
                              _logoutUser();
                              // Close the dialog and navigate to the login screen
                              Navigator.of(context).pop();
                              Get.offAllNamed(
                                  '/login'); // Navigate to login screen
                            },
                            child: Text('Logout'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/png/background.png'),
                  // Path to your image
                  fit: BoxFit.fill, // Cover the entire screen
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 130,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(45)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 35),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/png/profile.png'),
                                radius: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Hello,",
                                      style: GoogleFonts.dancingScript(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  Text(_fullName,
                                      style: GoogleFonts.inknutAntiqua(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                          top: Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Image.asset(
                              'assets/png/responder.png',
                              color: Colors.black, // Path to your SVG file
                            ),
                            iconSize: 50.0,
                            onPressed: () {
                              Get.to(ResponderListScreen());
                            },
                          ),
                          // Second Image Icon Button
                          IconButton(
                            icon: Image.asset('assets/png/logo1.png'),
                            iconSize: 100,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  final List<Map<String, String>> pdfFiles = [
                                    {
                                      'name': 'TrainingHandBook',
                                      'path': 'assets/pdf/TrainingHandBook.pdf',
                                    },
                                    {
                                      'name': 'EscortServices',
                                      'path': 'assets/pdf/EscortServices.pdf',
                                    },
                                    {
                                      'name': 'MPRRScoreCard',
                                      'path': 'assets/pdf/MPRRScoreCard.pdf',
                                    },
                                    {
                                      'name': 'QRFBrochure',
                                      'path': 'assets/pdf/QRFBrochure.pdf',
                                    },
                                    {
                                      'name': 'PIFFERSHiring&ScreeningFile',
                                      'path':
                                          'assets/pdf/PIFFERSHiring&ScreeningFile.pdf',
                                    },
                                    {
                                      'name': 'PIFFERSSecurityServices',
                                      'path':
                                          'assets/pdf/PIFFERSSecurityServices.pdf',
                                    },
                                    {
                                      'name': 'PIFFERSSecurityUniformGallery',
                                      'path':
                                          'assets/pdf/PIFFERSSecurityUniformGallery.pdf',
                                    },
                                    {
                                      'name': 'PIFFERSSecurityWeaponGallery',
                                      'path':
                                          'assets/pdf/PIFFERSSecurityWeaponGallery.pdf',
                                    },
                                    {
                                      'name': 'PsychotherapyProgressReport',
                                      'path':
                                          'assets/pdf/PsychotherapyProgressReport.pdf',
                                    },
                                  ];

                                  return ListView.builder(
                                    itemCount: pdfFiles.length,
                                    itemBuilder: (context, index) {
                                      final pdf = pdfFiles[index];

                                      return Obx(() {
                                        // Get the selected PDF path from GetX
                                        final selectedPdfPath =
                                            pdfController.selectedPdfPath.value;

                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // Set width based on screen size
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.picture_as_pdf,
                                                  color: Colors.blue),
                                              // Leading PDF icon
                                              title: Text(pdf['name']!),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  // Check if this PDF is selected
                                                  Icons.visibility,

                                                  color: selectedPdfPath ==
                                                          pdf['path']
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                ),
                                                onPressed: () {
                                                  // Toggle selection using GetX controller
                                                  pdfController
                                                      .togglePdfSelection(
                                                          pdf['path']!);
                                                  Get.to(PdfViewerScreen(
                                                      pdfPath: pdf['path']!));
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),

                          // Third Image Icon Button
                          IconButton(
                            icon: Image.asset('assets/png/logo2.png'),
                            iconSize: 100,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  final List<Map<String, String>> pdfFiles = [
                                    {
                                      'name': 'PIFFERSSedulous',
                                      'path': 'assets/pdf/PIFFERSSedulous.pdf'
                                    },
                                    {
                                      'name': 'SedulousProfile',
                                      'path': 'assets/pdf/SedulousProfile.pdf'
                                    },
                                    {
                                      'name': 'TrainingHandBook',
                                      'path': 'assets/pdf/TrainingHandBook.pdf'
                                    },
                                  ];

                                  return ListView.builder(
                                    itemCount: pdfFiles.length,
                                    itemBuilder: (context, index) {
                                      final pdf = pdfFiles[index];

                                      return Obx(() {
                                        // Get the selected PDF path from GetX
                                        final selectedPdfPath =
                                            pdfController.selectedPdfPath.value;

                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // Set width based on screen size
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ListTile(
                                              leading: const Icon(
                                                  Icons.picture_as_pdf,
                                                  color: Colors.blue),
                                              // Leading PDF icon
                                              title: Text(pdf['name']!),
                                              trailing: IconButton(
                                                icon: Icon(
                                                  // Check if this PDF is selected
                                                  Icons.visibility,

                                                  color: selectedPdfPath ==
                                                          pdf['path']
                                                      ? Colors.blue
                                                      : Colors.grey,
                                                ),
                                                onPressed: () {
                                                  // Toggle selection using GetX controller
                                                  pdfController
                                                      .togglePdfSelection(
                                                          pdf['path']!);
                                                  Get.to(PdfViewerScreen(
                                                      pdfPath: pdf['path']!));
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          // Fourth Image Icon Button
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/svg/more.svg', // Path to your SVG file
                            ),
                            iconSize: 50.0,
                            onPressed: () {
                              Get.to(MoreScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Wrap Stack in Expanded to allow it to use available space
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    // Center the widgets by default
                    children: [
                      // HELP Button in the center

                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.12,
                        child: InkWell(
                          onTap: () {
                            Get.dialog(CountdownDialog());
                          },
                          child: SvgPicture.asset(
                              'assets/svg/helpB.svg', // Path to your SVG file
                              width: MediaQuery.of(context).size.width * 0.1,
                              // Adjust width relative to screen size
                              height: MediaQuery.of(context).size.height *
                                  0.2 // Adjust height relative to screen size
                              ),
                        ),
                      ),

                      // KEEP AN EYE Button (top-right relative to the center)
                      Positioned(
                        right: MediaQuery.of(context).size.width *
                            0.05, // Adjust right margin
                        top: MediaQuery.of(context).size.height *
                            0.01, // Adjust top margin
                        child: InkWell(
                          onTap: openGoogleMaps,
                          // Trigger the map view implementation
                          child: SvgPicture.asset(
                            'assets/svg/kEye.svg', // Path to your SVG file
                            fit: BoxFit.contain,
                            width: MediaQuery.of(context).size.width * 0.15,
                            // Adjust width relative to screen size
                            height: MediaQuery.of(context).size.height *
                                0.08, // Adjust height relative to screen size
                          ),
                        ),
                      ),

                      // Self Response (left of the center)

                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.height * 0.07,
                        child: Column(
                          children: [
                            Utils().buildCategoryItem("assets/png/selfR.png"),
                          ],
                        ),
                      ),

                      // Add Responder (bottom-left relative to the center)

                      Positioned(
                        left: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.16,
                        child: Column(
                          children: [
                            Utils().buildCategoryItem("assets/png/Croom.png"),
                          ],
                        ),
                      ),

                      // More (bottom-right relative to the center)

                      Positioned(
                        left: MediaQuery.of(context).size.height * 0.06,
                        bottom: MediaQuery.of(context).size.height * 0.02,
                        child: Column(
                          children: [
                            Utils().buildCategoryItem("assets/png/Bike.png"),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logoutUser() async {
    authController.logout();
  }

  Future<void> openGoogleMaps() async {
    const String lat = "33.6844"; // Latitude for Islamabad
    const String lng = "73.0479"; // Longitude for Islamabad
    final Uri googleMapsUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw "Could not open Google Maps.";
    }
  }
}
