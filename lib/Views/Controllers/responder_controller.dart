import 'package:get/get.dart';
import 'package:piffers/Views/Api%20Services/apiservice.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'authcontroller.dart';

class ResponderController extends GetxController {
  List<dynamic> responders = [];
  bool isLoading = true;

  Future<void> fetchResponders() async {
    try {
      print("Fetching responders..."); // Debug log
      isLoading = true;
      update(); // Notify the UI to show the loader

      String? token = await Utils.getString('token'); // Ensure token is valid
      if (token == null) {
        print("Error: Token is null"); // Debug log
        throw Exception("Token not found");
      }

      // API Call
      final data = await ApiService.getResponders(token);
      print("API Response: $data"); // Debug log

      // Check if data is a list and contains responders
      if (data is List) {
        responders = data;
        print("Responders fetched: ${responders.length}"); // Debug log
      } else {
        print("Unexpected data format: $data"); // Debug log
      }

      isLoading = false; // Set loading to false
      update(); // Notify the UI to hide the loader
    } catch (e) {
      print("Error fetching responders: $e"); // Debug log
      isLoading = false; // Ensure loading stops on error
      update();
    }
  }
}




