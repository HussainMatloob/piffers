import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:piffers/Views/Controllers/authcontroller.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://sos.piffers.net/api";

  final AuthController authController = AuthController();
  // Register API

  static Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("https://sos.piffers.net/api/register"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(data),
      );

      // Check for redirects
      if (response.statusCode == 302 || response.statusCode == 301) {
        throw Exception("Unexpected redirect. Check API URL.");
      }

      if (response.statusCode != 200) {
        // print(response.statusCode);
        // print("Api Response  Error:  ${response.body}");
        throw Exception("Error: ${response.statusCode} - ${response.body}");
      }

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is! Map<String, dynamic>) {
        throw Exception("Invalid response format. Expected JSON object.");
      }
      return jsonResponse;
    } catch (e) {
      print("API Error: $e");
      return {"success": false, "message": e.toString()};
    }
  }

  // Login API
  static Future<Map> loginUser(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  // Logout API
  static Future<void> logoutUser(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application.json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to log out");
    }
  }

// Send OTP API
  static Future<void> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password-reset-otp'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to send OTP. Please try again.");
    }
  }

  // Reset Password API
  static Future<void> resetPassword(
    String email,
    String otp,
    String password,
    String confirmPassword,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'otp': otp,
        'password': password,
        'password_confirmation': confirmPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to reset password. Please try again.");
    }
  }

  // Forgot Password API
  static Future<void> sendResetPasswordEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/password-reset-otp'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );
      print(" +++++++++++++++++++ ${email.toString()}");
      print(" +++++++++++++++++++ ${response.body}");
      if (response.statusCode != 200) {
        throw Exception("Failed to send reset password email");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> requestHelp({
    required String message,
    required double latitude,
    required double longitude,
    required String location,
  }) async {
    String? token = await Utils.getString('token');

    if (token == null) {
      throw Exception('Token is null. Ensure the user is logged in.');
    }

    final url = Uri.parse('$baseUrl/request-help');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({
      'location': location,
      'message': message,
      'latitude': latitude,
      'longitude': longitude,
    });

    print('Sending help request...');
    print('URL: $url');
    print('Headers: $headers');
    print('Body: $body');

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Parse the response and return the message
        final parsedResponse = jsonDecode(response.body);
        print('Parsed response: $parsedResponse');
        return parsedResponse; // Should return {"message": "..."}
      } else {
        throw Exception(
            'Failed to send help request. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred: $e');
      throw Exception('Error sending help request: $e');
    }
  }

  // Add responder API
  static Future<void> addResponder({
    required String name,
    required String fatherName,
    required String relation,
    required String cnic,
    required String email,
    required String phone,
    required String address,
    required File responderImage,
  }) async {
    String? token = await Utils.getString('token'); // Fetch the token
    final uri = Uri.parse('$baseUrl/store-responders');

    // Create multipart request
    var request = http.MultipartRequest('POST', uri);

    // Add headers
    request.headers.addAll({
      'Authorization': 'Bearer $token', // Authorization header
      'Accept': 'application/json', // Accept JSON response
    });

    // Add fields to the request
    request.fields['name'] = name;
    request.fields['father_name'] = fatherName;
    request.fields['relation'] = relation;
    request.fields['cnic'] = cnic;
    request.fields['email'] = email;
    request.fields['phone'] = phone;
    request.fields['address'] = address;

    // Attach image as a file field
    if (responderImage.existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'responder_image', // Field name expected by the server
        responderImage.path,
      ));
    } else {
      throw Exception(
          "Image file does not exist at path: ${responderImage.path}");
    }

    // Send the request
    final response = await request.send();

    // Handle the response
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = await response.stream.bytesToString();
      print('Responder added successfully');
      print('Response: $responseData');
    } else {
      final responseData = await response.stream.bytesToString();
      print('Failed to add responder. Status code: ${response.statusCode}');
      print('Response: $responseData');
      throw Exception("Failed to add responder: $responseData");
    }
  }

  static Future<List<dynamic>> getResponders(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/responders'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Decode the response body to a list of responders
      final List<dynamic> data = json.decode(response.body);
      return data; // Return the list
    } else {
      throw Exception('Failed to load responders');
    }
  }

  Future<Map<String, String>> verifyOtp(String otp) async {
    final url = Uri.parse("$baseUrl/verify-otp");

    // Ensure email is not empty before making the request
    String? email = await Utils.getString("email");
    print(" Email is : $email");
    if (email!.isEmpty) {
      return {"message": "Email is missing", "status": "error"};
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "otp": otp,
          "email": email,
        }),
      );

      print("Request URL: $url");
      print("Response Status Code: ${response.statusCode}");
      print("Full Response: ${response.body}");

      if (response.statusCode == 200) {
        // Decode response safely
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        return {
          "message": responseData["message"] ?? "No message",
          "status": responseData["status"] ?? "error",
        };
      } else {
        return {"message": "OTP verification failed", "status": "error"};
      }
    } catch (e) {
      print("Error in verifyOtp: $e");
      return {"message": "Something went wrong", "status": "error"};
    }
  }

  Future<Map<String, dynamic>> resendOtp(String email) async {
    final url = Uri.parse("$baseUrl/resend-otp");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "email": email,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      return {"message": "Something went wrong", "status": "error"};
    }
  }

  // Private helper to process responses
  static Map _processResponse(http.Response response) {
    try {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is! Map) {
        throw Exception("Invalid JSON response");
      }

      return jsonResponse;
    } catch (e) {
      print("Error processing response: ${response.body}");
      throw Exception("Error: ${response.body}");
    }
  }
}
