import 'package:get/get.dart';
import 'package:piffers/Views/Api%20Services/apiservice.dart';
import 'package:piffers/Views/Utils/utils.dart';
import 'authcontroller.dart';

class ResponderController extends GetxController {
  List<dynamic> responders = []; // Plain list without RxList
  bool isLoading = true;

  Future<void> fetchResponders() async {
    try {
      // Set loading state to true
      isLoading = true;

      // Fetch responders from the API
      String? token = await Utils.getString('token'); // Get token
      final data = await ApiService.getResponders(token!);

      // Assuming 'data' is a List of responders, update the list
      responders = data; // No need for RxList, just a normal List

      // Set loading state to false after data is fetched
      isLoading = false;
      update(); // Update UI (you can also use setState in the widget)
    } catch (e) {
      print("Error fetching responders: $e");
      isLoading = false;
      update(); // Update UI in case of error
    }
  }
}




