import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:piffers/Views/BottomNav/AddResponder.dart';
import '../Controllers/responder_controller.dart';


class ResponderListScreen extends StatefulWidget {
  @override
  _ResponderListScreenState createState() => _ResponderListScreenState();
}

class _ResponderListScreenState extends State<ResponderListScreen> {
  final ResponderController responderController = Get.put(ResponderController());

  @override
  void initState() {
    super.initState();
    responderController.fetchResponders();
  }

  @override
  Widget build(BuildContext context) {
    responderController.fetchResponders();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responders'),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              // Navigate to the Add Responder screen
              Get.to(Addresponder());
            },
          ),
        ],
      ),

      body: GetBuilder<ResponderController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // If no responders are available
          if (controller.responders.isEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No responders found',
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Get.to(Addresponder());
                    },
                    child: const Text(
                      'Add responder',
                      style: TextStyle(fontSize: 22, color: Colors.lightBlue),
                    ),
                  ),
                ],
              ),
            );
          }

          // If responders are available, display them in a list
          return ListView.builder(
            itemCount: controller.responders.length,
            itemBuilder: (context, index) {
              final responder = controller.responders[index];

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: responder['responders_image'] != null
                                  ? NetworkImage(
                                  "https://sos.piffers.net/${responder['responders_image']}")
                                  : const AssetImage('assets/images/placeholder.png')
                              as ImageProvider,
                              onBackgroundImageError: (exception, stackTrace) {
                                print('Error loading image: $exception');
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    responder['name'] ?? 'N/A',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Email: ${responder['email'] ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Phone: ${responder['phone'] ?? 'N/A'}",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(7, 52, 91, 1),
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onPressed: () {
                              // Display responder details
                              Get.dialog(AlertDialog(
                                title: Text('Details for ${responder['name'] ?? 'Unknown'}'),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Father Name: ${responder['father_name'] ?? 'N/A'}"),
                                    Text("CNIC: ${responder['cnic'] ?? 'N/A'}"),
                                    Text("Relation: ${responder['relation'] ?? 'N/A'}"),
                                    Text("Address: ${responder['address'] ?? 'N/A'}"),
                                    Text("Email: ${responder['email'] ?? 'N/A'}"),
                                    Text("Phone: ${responder['phone'] ?? 'N/A'}"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("Close"),
                                  ),
                                ],
                              ));
                            },
                            child: const Text(
                              "View Details",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 10,bottom: 10),
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to the Add Responder screen
            Get.to(Addresponder());
          },
          backgroundColor: const Color.fromRGBO(7, 52, 91, 1),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),

    );

  }
}





