import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  final nameController = TextEditingController();
  final companyNameController = TextEditingController();
  final subjectController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final postalAddressController = TextEditingController();
  final messageController = TextEditingController();

  var selectedService = ''.obs;
  var needCalendar = false.obs;

  final formKey = GlobalKey<FormState>();

  void submitForm() {
    if (formKey.currentState!.validate()) {
      // Handle successful form submission
      Get.snackbar(
        "Success",
        "Form submitted successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please fill all required fields",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
