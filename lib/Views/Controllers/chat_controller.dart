import 'package:get/get.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  var messageText = ''.obs;
  void sendMessage(String content, bool isUserMessage) {
    messages.add(ChatMessage(content: content, isUserMessage: isUserMessage));
  }
}

class ChatMessage {
  final String content;
  final bool isUserMessage;

  ChatMessage({required this.content, required this.isUserMessage});
}
