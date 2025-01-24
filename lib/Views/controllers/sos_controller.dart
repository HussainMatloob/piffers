import 'package:get/get.dart';
class SOSController extends GetxController {
  var timerText = '10'.obs;
  var countdown = 10.obs;
  var isTimerRunning = false.obs;
  var isTimerEnded = false.obs;

  void startTimer() {
    isTimerRunning.value = true;
    isTimerEnded.value = false;
    countdown.value = 10;
    timerText.value = countdown.value.toString();
    Future.delayed(Duration(seconds: 1), updateTimer);
  }

  void updateTimer() {
    if (countdown.value > 0) {
      countdown.value--;
      timerText.value = countdown.value.toString();
      Future.delayed(Duration(seconds: 1), updateTimer);
    } else {
      timerText.value = '!';
      isTimerEnded.value = true;
    }
  }

  void cancelTimer() {
    isTimerRunning.value = false;
    isTimerEnded.value = false;
    timerText.value = 'Tap to\n send SOS';
  }
}