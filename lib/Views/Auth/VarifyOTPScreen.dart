import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/authcontroller.dart';
import '../Controllers/otp_controller.dart';
import '../Controllers/resent_top_controller.dart';
import '../Utils/utils.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final OtpController otpController = Get.put(OtpController());
  final ResendOtpController resendOtpController =
      Get.put(ResendOtpController());

  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());

  Future<void> _handleVerifyOtp() async {
    String otp = _otpControllers.map((c) => c.text.trim()).join();
    if (otp.length < 6) {
      Get.snackbar(
        "Error",
        "Please enter a valid 5-digit OTP",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

  await otpController.verifyOtp(otp);

    // print("Entered OTP: $otp");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(1, 39, 71, 1),
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/png/authB.png", // Background image
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // "Verify OTP" Title
                    Text(
                      "Verify OTP",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      "Enter the 6-digit code sent to your Email",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // OTP Input Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        6,
                        (index) => Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: _otpControllers[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(fontSize: 22),
                            decoration: const InputDecoration(
                              counterText: "",
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 5) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Verify OTP Button
                    Obx(
                      () {
                        return otpController.isLoading.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _handleVerifyOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(124, 2, 16, 1.0),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Verify OTP',
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                      },
                    ),

                    const SizedBox(height: 20),

                    // Resend OTP
                    Obx(
                      () {
                        if (resendOtpController.isLoading.value) {
                          return const CircularProgressIndicator();
                        } else {
                          return InkWell(
                            onTap: () async {
                              String? email = await Utils.getString("email");

                              // Validate email
                              if (email == null || email.isEmpty) {
                                Get.snackbar(
                                  "Error",
                                  "Email not found",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              await resendOtpController.resendOtp(email);

                              // Show response message after API call
                              if (resendOtpController.status.value == "success") {
                                Get.snackbar(
                                  "Success",
                                  resendOtpController.message.value,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                              } else {
                                Get.snackbar(
                                  "Error",
                                  resendOtpController.message.value,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            child: const Text(
                              "Resend OTP?",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
