import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Api%20Services/apiservice.dart';
import 'package:piffers/Views/Auth/Login.dart';

class OtpController extends GetxController {
  final ApiService _apiService = ApiService();
  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;
  final RxString status = ''.obs;

  Future<void> verifyOtp(String otp) async {
    isLoading(true);
    try {
      final response = await _apiService.verifyOtp(otp);
      message(response["message"] ?? "Unknown response");
      status(response["status"] ?? "error");

      if (status.value == "success") {
        Get.snackbar("Success", message.value,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white);
        // Navigate to next screen if needed
        Get.to(const Login());
      } else {
        Get.snackbar("Error : ", message.value,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading(false);
    }
  }
}
