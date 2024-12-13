import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/controllers/authcontroller.dart';
import 'package:google_fonts/google_fonts.dart'; // If you're using Google Fonts

class Addresponder extends StatefulWidget {
  @override
  _AddresponderState createState() => _AddresponderState();
}

class _AddresponderState extends State<Addresponder> {
  final _formKey2 = GlobalKey<FormState>();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final AuthController authController = Get.put(AuthController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _fathernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _relationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add Responder'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Circular Image Picker
                GestureDetector(
                  onTap: () {
                    // Add logic to pick image
                    _showImagePickerDialog();
                  },
                  child: CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.grey.shade300,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey.shade300,
                      child: _image == null
                          ? const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            )
                          : ClipOval(
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                                width: 180,
                                height: 180,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Name Field
                Utils().buildTextField(
                  "Name:",
                  _nameController,
                ),
                const SizedBox(height: 10),

                Utils().buildTextField(
                  "Father Name:",
                  _fathernameController,
                ),
                const SizedBox(height: 10),

                Utils().buildTextField(
                  "Relation:",
                  _relationController,
                ),
                const SizedBox(height: 10),

                // Email Field
                Utils().buildTextField(
                  "Email:",
                  _emailController,
                ),
                const SizedBox(height: 10),

                // Phone Field
                Utils().buildTextField(
                  "Phone No: ",
                  _phoneNoController,
                ),

                const SizedBox(height: 10),

                // Phone Field
                Utils().buildTextField("CNIC: ", _cnicController),

                const SizedBox(height: 10),

                // Phone Field
                Utils().buildTextField(
                  "Address: ",
                  _addressController,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Obx(() {
                      return authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                if (_formKey2.currentState!.validate()) {
                                  _formKey2.currentState!.save();

                                  File _imageFile = File(_image!.path);

                                  authController.addResponder(
                                      name: _nameController.text.toString(),
                                      address: _addressController.text.toString(),
                                      cnic: _cnicController.text.toString(),
                                      email: _emailController.text.toString(),
                                      fatherName: _fathernameController.text.toString(),
                                      phone: _phoneNoController.text.toString(),
                                      relation: _relationController.text.toString(),
                                      responderImage: _imageFile );// _image is a string path



                                  print(
                                      "File image Path:   ${_image.toString()}");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(7, 52, 91, 1),
                                // Custom RGBO color
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 100, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                'Add Responder',
                                style: GoogleFonts.nunitoSans(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(source: source);

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print('No image selected');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Function to show a dialog to select either camera or gallery
  Future<void> _showImagePickerDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick an Image'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera); // Open the camera
                },
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery); // Open the gallery
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
