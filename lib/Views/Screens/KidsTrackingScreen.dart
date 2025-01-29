import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/kids_tracking_controller.dart';
import 'package:google_fonts/google_fonts.dart';

class KidTrackingScreen extends StatelessWidget {
  final KidTrackingController controller = Get.put(KidTrackingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(1, 46, 85, 1),
        title:  Text('Kid Tracking',style: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.white
        ),),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Obx(() {
            return GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.selectedKid.value.location,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId(controller.selectedKid.value.name),
                  position: controller.selectedKid.value.location,
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
                  itemCount: controller.kids.length,
                  itemBuilder: (context, index) {
                    final kid = controller.kids[index];
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(kid.name[0]),
                      ),
                      title: Text(kid.name, style: GoogleFonts.outfit(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),),
                      subtitle: Text('${kid.status}\n${kid.time} ' , style: GoogleFonts.outfit(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),),
                      onTap: () => controller.selectKid(kid),
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
