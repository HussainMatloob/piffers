import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/pet_trackting_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class PetTrackingScreen extends StatelessWidget {
  final PetTrackingController controller = Get.put(PetTrackingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Pet Tracking', style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white
        ),),
        backgroundColor: Color.fromRGBO(1, 46, 85, 1),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.selectedPet.value.location,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(controller.selectedPet.value.name),
                  position: controller.selectedPet.value.location,
                ),
              },
            );
          }),
          DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.1,
            maxChildSize: 0.5,
            builder: (context, scrollController) {
              return Container(
                color: Colors.white,
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: controller.pets.length,
                  itemBuilder: (context, index) {
                    final pet = controller.pets[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(pet.name[0]),
                      ),
                      title: Text(pet.name, style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),),
                      subtitle: Text('${pet.status}\n${pet.time}' , style: GoogleFonts.outfit(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),),
                      onTap: () => controller.selectPet(pet),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
