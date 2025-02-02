import 'package:get/get.dart';

import '../Api Services/apiservice.dart';

class HelpController extends GetxController {
  final ApiService apiService;

  HelpController({required this.apiService});

  var isLoading = false.obs;
  var responseMessage = ''.obs;

  // void requestHelp({
  //   required String location,
  //   required String message,
  //   required double latitude,
  //   required double longitude,
  //   required String bearerToken,
  // }) async {
  //   try {
  //     isLoading.value = true;
  //     final response = await apiService.requestHelp(
  //       message: message,
  //       latitude: latitude,
  //       longitude: longitude,
  //     );
  //     responseMessage.value = response['message'];
  //   } catch (e) {
  //     responseMessage.value = 'Error: $e';
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
