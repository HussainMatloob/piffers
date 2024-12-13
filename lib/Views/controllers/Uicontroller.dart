import 'dart:ui';

import 'package:get/get.dart';

class UIController extends GetxController {
  // Define initial relative positions (percentages of screen width/height)
  var selfResponderPosition = Offset(0.2, 0.1).obs;  // 20% of width, 10% of height
  var addResponderPosition = Offset(0.1, 0.2).obs;   // 10% of width, 30% of height
  var morePosition = Offset(0.2, 0.06).obs;          // 30% of width, 20% of height
}
