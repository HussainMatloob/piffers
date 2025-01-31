import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/BottomNav/MoreScreen.dart';
import 'package:piffers/Views/BottomNav/RespondersList.dart';
import 'package:piffers/Views/PdfScreen.dart';
import 'package:piffers/Views/Screens/PetTrackingScreen.dart';
import 'package:piffers/Views/Screens/SOSscreen.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/Auth/ForgotPassworsd.dart';
import 'package:piffers/Views/Controllers/Uicontroller.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:piffers/Views/controllers/pdfcontroller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Controllers/notification_controller.dart';
import '../Screens/NewPlaceScreen.dart';
import '../Screens/NotificationListScreen.dart';
import '../Screens/UserProfile.dart';
import '../Widgets/eye_container.dart';
import '../controllers/places_controller.dart';
import 'AddResponder.dart';
import 'package:badges/badges.dart' as badges;

class LocateResponder extends StatefulWidget {
  @override
  _LocateResponderState createState() => _LocateResponderState();
}

class _LocateResponderState extends State<LocateResponder> {

  final PlaceController placeController = Get.put(PlaceController());
  // Track the selected index for bottom navigation
  final AuthController authController = Get.put(AuthController());
  final UIController uiController = Get.put(UIController());
  final PdfController pdfController =
      Get.put(PdfController()); // Create an instance of PdfController
  final NotificationController controller = Get.put(NotificationController());

  String _fullName = "";

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  // Load full name from SharedPreferences
  Future<void> _loadFullName() async {
    String? fullName = await fetchName();
    setState(() {
      _fullName = fullName!;
    });
  }

  double initialPosition = 0.0;

  void _showTopDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onVerticalDragEnd: (details) {
            // Close the dialog on swipe up
            if (details.velocity.pixelsPerSecond.dy < -500) {
              Navigator.of(context).pop();
            }
          },
          child: Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'People',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        children: [
                          CircleAvatar(
                            maxRadius: 30,
                            child: ClipRect(

                              child: Image.asset("assets/png/profile.png"),),

                          )
                          ,
                          const SizedBox(width: 16,
                          ),

                            Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${_fullName.toString()}", style: const TextStyle(fontSize: 18, color: Colors.black),),
                              const Text("At Office", style: TextStyle(fontSize: 12, color: Colors.black),),
                              const Text("Since 6:00 am", style: TextStyle(fontSize: 12, color: Colors.black),)

                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 8,),
                       GestureDetector(
                         onTap: (){
                           Get.to(Addresponder());
                         },
                         child: const Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              child: ClipRect(
                                child: Icon(Icons.person_add_alt_1_sharp, size: 35,color: Colors.black,),
                            ),
                            ),

                            SizedBox(width: 16,),
                            Text("Add A Responder", style: TextStyle(fontSize: 18, color: Colors.black),)
                          ],
                                               ),
                       ),

                      const SizedBox(height: 16,),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Item',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),
                      GestureDetector(
                        onTap: (){

                          Get.to(PetTrackingScreen());
                        },
                        child: const Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              child: ClipRect(
                                child: Icon(Icons.key_sharp, size: 35,color: Colors.black,),

                              ),
                            ),

                            const SizedBox(width: 16,
                            ),
                            Text("Track your Pets", style: TextStyle(fontSize: 18, color: Colors.black),)
                          ],
                        ),
                      ),
                      const SizedBox(height: 16,),

                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Manage Places',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8,),

                       GestureDetector(
                         onTap: (){
                           Get.to(AddNewPlaceScreen());
                         },
                         child: const Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 30,
                              child: ClipRect(

                                child: Icon(Icons.account_balance_rounded, size: 35,color: Colors.black,),

                              ),
                            ),

                            SizedBox(width: 8,
                            ),
                            Text("Manage Places", style: TextStyle(fontSize: 18, color: Colors.black),)
                          ],
                                               ),
                       ),


                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String?> fetchName() async {
    // Try to get the full name saved in shared preferences
    String? fullName = await Utils.getString("name"); // 'name' is the key for the full name

    if (fullName != null && fullName.isNotEmpty) {
      // If full name is found, return it
      return fullName;
    } else {
      return fullName!.isEmpty ? "Armughan Tallat Khan" : fullName;
    }
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
          actions:[
            Obx(() => badges.Badge(
              badgeContent: Text(
                controller.notificationCount.value.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              showBadge: controller.notificationList.length > 0,
              child: IconButton(
                icon: const Icon(Icons.notifications,size: 30,),
                onPressed: () {
                  // Navigate to Notification Screen
                 Get.to(NotificationListScreen());

                },
              ),
            )),
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
                  Get.to(UserProfileScreen());
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
                  Get.to(ForgotPassword());

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
              const Divider(),
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
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Close the dialog
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
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
                            child: const Text('Logout'),
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
            // Full-screen background image using AssetImage
            Positioned(
              top: 80, // Adjust this value to move the image down
              bottom: -50, // Adjust this value to move the image down
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/png/mianB.png'), // Your PNG image
                    fit: BoxFit.cover, // Ensures it covers the entire screen
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Container(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(8)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
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
                                    Text(_fullName,
                                        style: GoogleFonts.inknutAntiqua(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        )),
                                    const Text("At Office", style: TextStyle(fontSize: 12, color: Colors.black),),
                                    const Text("Since 6:00 am", style: TextStyle(fontSize: 12, color: Colors.black),)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: GestureDetector(
                            onVerticalDragStart: (details) {
                              initialPosition = details.localPosition.dy;
                            },
                            onVerticalDragUpdate: (details) {
                              double delta =
                                  details.localPosition.dy - initialPosition;

                              // Trigger dialog when the swipe gesture moves down by a certain threshold
                              if (delta > 50) {
                                _showTopDialog(context);
                              }
                            },
                            child: Column(
                              spacing: 3,
                              children: [
                                Container(
                                width: 70,
                                height: 4,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),   Container(
                                width: 50,
                                height: 4,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ), Container(
                                width: 30,
                                height: 3,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),

                            ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5,left: 3,right: 3),
                    child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8),
                              top: Radius.circular(8)),
                        ),
                        child: Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/png/responder.png',
                                    height: double.infinity,
                                  ),
                                  iconSize: 70.0,
                                  onPressed: () {
                                    Get.to(ResponderListScreen());
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/png/keys.png',
                                    height: double.infinity,
                                  ),
                                  iconSize: 70.0,
                                  onPressed: () {
                                    Get.to(MoreScreen());
                                  },
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/png/logo1.png',
                                    height: double.infinity,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final List<Map<String, String>> pdfFiles = [
                                          {
                                            'name': 'TrainingHandBook',
                                            'path':
                                                'assets/pdf/TrainingHandBook.pdf',
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
                                              final selectedPdfPath = pdfController
                                                  .selectedPdfPath.value;

                                              return Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 15),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    title: Text(pdf['name']!),
                                                    trailing: IconButton(
                                                      icon: Icon(
                                                        Icons.visibility,
                                                        color: selectedPdfPath ==
                                                                pdf['path']
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                      ),
                                                      onPressed: () {
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
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                  icon: Image.asset(
                                    'assets/png/logo2.png',
                                    height: double.infinity,
                                  ),

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
                                            'path':
                                                'assets/pdf/TrainingHandBook.pdf'
                                          },
                                        ];

                                        return ListView.builder(
                                          itemCount: pdfFiles.length,
                                          itemBuilder: (context, index) {

                                            final pdf = pdfFiles[index];
                                            return Obx(() {
                                              final selectedPdfPath = pdfController
                                                  .selectedPdfPath.value;

                                              return Container(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 5, horizontal: 15),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
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
                                                    title: Text(pdf['name']!),
                                                    trailing: IconButton(
                                                      icon: Icon(
                                                        Icons.visibility,
                                                        color: selectedPdfPath ==
                                                                pdf['path']
                                                            ? Colors.blue
                                                            : Colors.grey,
                                                      ),
                                                      onPressed: () {
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
                              ),
                            ],
                          ),
                        )),
                  ),
                  // Wrap Stack in Expanded to allow it to use available space
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          top: 110, // Adjust top margin
                          child: Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                Get.dialog(SOSScreen());
                              },
                              child: SvgPicture.asset(
                                'assets/svg/helpB.svg',
                                width: Get.width * 0.5,
                                // Adjust width relative to screen width
                                height: Get.height *
                                    0.28, // Adjust height relative to screen height
                              ),
                            ),
                          ),
                        ),

                        // KEEP AN EYE Button (top-right relative to the center)
                        Positioned(
                          right: Get.width * 0.02, // Adjust right margin
                          top: Get.height * 0.0, // Adjust top margin
                          child: SvgPicture.asset(
                            'assets/svg/email.svg',
                            fit: BoxFit.contain,
                            width: Get.width * 0.15,
                            // Adjust width for responsiveness
                            height: Get.height *
                                0.08, // Adjust height for responsiveness
                          ),
                        ),

                        // Self Response (top-left relative to the center)
                        Positioned(
                          top: Get.height * 0.015,
                          left: Get.width * 0.38,
                          child: Column(
                            children: [
                              Utils().buildCategoryItem("assets/png/selfR.png"),
                            ],
                          ),
                        ),

                        // Add Responder (bottom-left relative to the center)
                        Positioned(
                          left: Get.width * 0.03,
                          // Adjust position relative to screen width
                          bottom: Get.height * 0.1,
                          // Adjust position relative to screen height
                          child: Column(
                            children: [
                              Utils().buildCategoryItem("assets/png/Croom.png"),
                            ],
                          ),
                        ),

                        // More (bottom-right relative to the center)
                        Positioned(
                          right: Get.width * 0.03,
                          // Adjust position relative to screen width
                          bottom: Get.height * 0.1,
                          // Adjust position relative to screen height
                          child: Column(
                            children: [
                              Utils().buildCategoryItem("assets/png/Bike.png"),
                            ],
                          ),
                        ),

                        Positioned(
                          bottom: 15,
                          left: 10,
                          child: GestureDetector(
                              onTap: openGoogleMaps, child: EyeContainer()),
                        ),
                      ],
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

  Future<void> _logoutUser() async {
    authController.logout();
  }

  Future<void> openGoogleMaps() async {
    // Step 1: Check and Request Location Permissions
    var status = await Permission.location.request();

    if (status.isGranted) {
      // Permission granted, proceed to get the user's location
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        // Step 2: Construct Google Maps URL with user's coordinates
        final String lat = position.latitude.toString();
        final String lng = position.longitude.toString();
        final Uri googleMapsUrl = Uri.parse(
          "https://www.google.com/maps/search/?api=1&query=$lat,$lng",
        );

        // Step 3: Launch Google Maps
        if (await canLaunchUrl(googleMapsUrl)) {
          await launchUrl(googleMapsUrl);
        } else {
          throw "Could not open Google Maps.";
        }
      } catch (e) {
        print("Error getting location: $e");
      }
    } else if (status.isDenied || status.isPermanentlyDenied) {
      // Permission denied, notify the user
      print("Location permission denied or permanently denied.");
      // Optionally, open app settings for permanently denied permissions
      if (status.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
  }
}
