import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Api%20Services/apiservice.dart';

class ResendOtpController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;
  final RxString status = ''.obs;

  Future<void> resendOtp(String email) async {
    if (email.isEmpty) {
      Get.snackbar("Error", "Email cannot be empty", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading(true);
    try {
      final response = await _apiService.resendOtp(email);
      message(response["message"] ?? "Unknown response");
      status(response["status"] ?? "error");

      if (status.value == "success") {
        Get.snackbar("Success", message.value, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
      } else {
        Get.snackbar("Error", message.value, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}
