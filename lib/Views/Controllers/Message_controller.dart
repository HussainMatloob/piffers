import '../Models/Message.dart';
import 'package:get/get.dart';

class InboxController extends GetxController {
  var messages = [
    Message(
        name: 'Davis Raugh',
        message: 'Hello, how are you?',
        timestamp: 'Yesterday'),
    Message(
        name: 'Alice',
        message: 'Hello, how are you?',
        timestamp: 'Yesterday',
        unread: true),
    Message(
        name: 'Amanda', message: 'Hello, how are you?', timestamp: 'Yesterday'),
    Message(
        name: 'Robert', message: 'Hello, how are you?', timestamp: 'Yesterday'),
  ].obs;
}
