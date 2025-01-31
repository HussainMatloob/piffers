import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Utils/utils.dart';
import '../Controllers/Message_controller.dart';
import 'ChatScreen.dart';

class InboxScreen extends StatelessWidget {
  final controller = Get.put(InboxController());
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Inbox',
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),

      ),
      body: Column(
        children: [
          Utils().buildSearchField(searchController),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16),
                  child: Text(
                    "Messages",
                    style: GoogleFonts.outfit(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,

                    ),
                  ))),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  return Card(
                    elevation: 4.0,
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() =>
                            ChatScreen(
                                image: message.name[0], name: message.name));
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(message.name[0]),
                        ),
                        title: Text(message.name, style: GoogleFonts.outfit(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),),
                        subtitle: Text(
                          message.message, style: GoogleFonts.outfit(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(message.timestamp, style: GoogleFonts.outfit(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),),
                            if (message.unread)
                              Container(
                                margin: const EdgeInsets.only(top: 4.0),
                                padding: const EdgeInsets.all(4.0),
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),

        ],
      ),
    );
  }
}
