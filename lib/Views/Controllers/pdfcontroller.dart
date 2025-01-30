import 'package:get/get.dart';

class PdfController extends GetxController {
  // Observable variable for the selected PDF path
  var selectedPdfPath = Rx<String?>(null);

  // Function to toggle the selected PDF path
  void togglePdfSelection(String path) {
    if (selectedPdfPath.value == path) {
      selectedPdfPath.value = null;  // Deselect PDF if already selected
    } else {
      selectedPdfPath.value = path;  // Select the PDF
    }
  }
}
