import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';
import 'package:piffers/Views/PdfScreen.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:google_fonts/google_fonts.dart';

class LocateResponder extends StatefulWidget {
  @override
  _LocateResponderState createState() => _LocateResponderState();
}

class _LocateResponderState extends State<LocateResponder> {
  // Track the selected index for bottom navigation
  final AuthController authController = Get.put(AuthController());
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            "HOME",
            style: GoogleFonts.inknutAntiqua(
              fontSize: 26,
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
                  width: double.infinity,
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
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                          top: Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          iconSize: 120.0,
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
                                    return ListTile(
                                      title: Text(pdf['name']!),
                                      onTap: () {
                                        Navigator.pop(
                                            context); // Close the modal
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PdfViewerScreen(
                                                    pdfPath: pdf['path']!),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          },
                        ),

                        // Third Image Icon Button
                        IconButton(
                          icon: Image.asset('assets/png/logo2.png'),
                          iconSize: 120.0,
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
                                    return ListTile(
                                      title: Text(pdf['name']!),
                                      onTap: () {
                                        Navigator.pop(
                                            context); // Close the modal
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PdfViewerScreen(
                                                    pdfPath: pdf['path']!),
                                          ),
                                        );
                                      },
                                    );
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
                // Wrap Stack in Expanded to allow it to use available space
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    // Center the widgets by default
                    children: [
                      // HELP Button in the center
                      Positioned(
                          right: 100,
                          bottom: 150,
                          child: SvgPicture.asset(
                            'assets/svg/helpB.svg', // Path to your SVG file
                            width: 180,
                            height: 180,
                          )),

                      // KEEP AN EYE Button (top-right relative to the center)
                      Positioned(
                        right: 10,
                        top: 10,
                        width: 100,
                        height: 100,
                        child: SvgPicture.asset(
                          'assets/svg/kEye.svg', // Path to your SVG file
                        ),
                      ),

                      // Self Response (left of the center)
                      Positioned(
                        left: 80,
                        top: 90,
                        child: Column(
                          children: [
                            Utils().buildCategoryItem("assets/png/selfR.png"),
                          ],
                        ),
                      ),

                      // Add Responder (bottom-left relative to the center)
                      Positioned(
                        left: 30,
                        bottom: 200,
                        child: Column(
                          children: [
                            Utils().buildCategoryItem("assets/png/Croom.png"),
                          ],
                        ),
                      ),

                      // More (bottom-right relative to the center)
                      Positioned(
                        left: 90,
                        bottom: 80,
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
}
