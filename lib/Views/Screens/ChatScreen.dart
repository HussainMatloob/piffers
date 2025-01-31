import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  final ChatController controller = Get.put(ChatController());
  final String image;
  final String name;

  ChatScreen({required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(1, 46, 85, 1),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: Text(
                image.toUpperCase(),
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: const TextStyle(fontSize: 16, color:  Colors.white),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              // Add call functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                reverse: true,
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message =
                  controller.messages[controller.messages.length - 1 - index];
                  return MessageBubble(message: message, );
                },
              );
            }),
          ),
          buildMessageInputField(),
        ],
      ),
    );
  }

  Widget buildMessageInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.blue.shade900),
            onPressed: () {
              // Implement file/image picker
            },
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                controller.messageText.value = value;
              },
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue.shade900),
            onPressed: () {
              if (controller.messageText.value.isNotEmpty) {
                controller.sendMessage(controller.messageText.value, true);
                controller.messageText.value = '';
              }
              controller.messageText.value = '';
            },
          ),
          IconButton(
            icon: Icon(Icons.mic, color: Colors.blue.shade900),
            onPressed: () {
              // Add voice message functionality
            },
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final isUserMessage = message.isUserMessage;
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue.shade900 : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isUserMessage ? const Radius.circular(12) : Radius.zero,
            bottomRight: isUserMessage ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Text(
          message.content,
          style: TextStyle(color: isUserMessage ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
