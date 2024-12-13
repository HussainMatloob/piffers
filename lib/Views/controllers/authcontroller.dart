import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/Api%20Services/apiservice.dart';
import 'package:piffers/Views/BottomNav/Bottom_navbar.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:piffers/Views/auth/Login.dart';

class AuthController extends GetxController {
  var isLoading = false.obs; // Reactive loading state
  var token = ''.obs;        // Reactive token state

  // Register User
  Future<void> register(String firstName, String lastName, String email, String password) async {
    try {
      isLoading(true);
      final response = await ApiService.registerUser({
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': password,
      });
      token.value = response['token'];
      Utils.saveString("token",  response['token']);
      Utils.saveString("firstname",  firstName);
      Utils.saveString("lastname",  lastName);
      Get.snackbar('Success', 'Registration successful!',snackPosition: SnackPosition.BOTTOM);
      Get.to(Login());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Login User
  Future<void> login(String email, String password) async {
    try {
      isLoading(true);
      final response = await ApiService.loginUser({
        'email': email,
        'password': password,
      });


      token.value = response['token'];
      Get.snackbar('Success', 'Login successful!',snackPosition: SnackPosition.BOTTOM);
      Get.to(BottomNavbar()); // Navigate to home screen
      Utils.saveString("token", response['token']);
      Utils.saveString("email", response[email]);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Logout User
  Future<void> logout() async {
    try {
      isLoading(true);
      String? token1=await  Utils.getString("token");
      await ApiService.logoutUser(token1.toString());
      Utils.clear();
      token.value = '';
      Get.offAllNamed('/login'); // Navigate to login screen
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Method to send OTP New
  Future<void> sendOtp( String email) async {
    try {
      await ApiService.sendOtp(email);
      Get.snackbar('Success', 'OTP sends succesfuly to ${email}',snackPosition: SnackPosition.BOTTOM);

    } catch (error) {
      Get.snackbar('Error', error.toString());

    }
  }

  // Method to reset password
  Future<void> resetPassword(
      String email,
      String otp,
      String password,
      String confirmPassword,
      ) async {
    try {
      await ApiService.resetPassword(email, otp, password, confirmPassword);
      Get.snackbar('Success', 'Password reset successfully',snackPosition: SnackPosition.BOTTOM);

    } catch (error) {
      Get.snackbar('Error', error.toString(),snackPosition: SnackPosition.BOTTOM);

    }
  }

  // Send Forgot Password Email
  Future<void> sendResetPasswordEmail(String email) async {
    try {
      isLoading(true);
      await ApiService.sendResetPasswordEmail(email);
      Get.snackbar('Success', 'Password reset email sent!',snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }


  // Reset Password
  Future<void> addResponder({
    required String name,
    required String fatherName,
    required String relation,
    required String cnic,
    required String email,
    required String phone,
    required String address,
    required File responderImage,
  }) async {
    // Input validation
    if (name.isEmpty ||
        fatherName.isEmpty ||
        relation.isEmpty ||
        cnic.isEmpty ||
        email.isEmpty ||
        phone.isEmpty ||
        address.isEmpty) {
      Get.snackbar(
        'Error',
        'Please provide all required fields!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (cnic.length != 15) {
      Get.snackbar(
        'Error',
        'CNIC must be 15 characters long!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isLoading(true); // Show loading state

      // Debugging logs for development
      print("Sending Responder Info...");
      print("Name: $name, Father Name: $fatherName, Relation: $relation");
      print("CNIC: $cnic, Email: $email, Phone: $phone");
      print("Address: $address, Image Path: ${responderImage.path}");

      // Call API service
      await ApiService.addResponder(
        name: name,
        fatherName: fatherName,
        relation: relation,
        cnic: cnic,
        email: email,
        phone: phone,
        address: address,
        responderImage: responderImage,
      );

      // Navigate to the bottom navigation bar screen
      Get.to(() => BottomNavbar());

      // Show success message
      Get.snackbar(
        'Success',
        'Responder added successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Error',
        'Failed to add responder: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error: ${e.toString()}");
    } finally {
      isLoading(false); // Stop loading state
    }
  }



}
