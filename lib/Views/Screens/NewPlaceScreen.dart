import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'MapViewScreen.dart';

class AddNewPlaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Add New Place'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            ListTile(
              leading: const ClipOval(
                child: Icon(
                  Icons.add_circle,
                  color: Colors.black, // Icon color
                  size: 40,
                ),
              ),
              title: const Text('Add a new place'),
              onTap: () {
                Get.to(() => MapViewScreen(placeType: 'Home'));
              },
            ),
            const Divider(),
            ListTile(
              leading: ClipOval(
                child: Container(
                  color: Colors.grey[300], // Optional: Background color for the circular icon
                  child: const Padding(
                    padding: EdgeInsets.all(8.0), // Adjust padding as needed
                    child: Icon(
                      Icons.home,
                      color: Colors.black, // Icon color
                    ),
                  ),
                ),
              ),
              title: const Text('Home'),
             trailing: const Icon(Icons.close, color: Colors.black,),
            ),
            const Divider(),
            ListTile(
              leading: ClipOval(
                child: Container(
                  color: Colors.grey[300],
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.work,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              title: const Text('Work'),
              trailing: const Icon(Icons.close, color: Colors.black,),

            ),
            const Divider(),
            ListTile(
              leading: ClipOval(
                child: Container(
                  color: Colors.grey[300],
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.fitness_center,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              title: const Text('Gym'),
              trailing: const Icon(Icons.close, color: Colors.black,),

            ),
            const Divider(),
            ListTile(
              leading: ClipOval(
                child: Container(
                  color: Colors.grey[300],
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.local_grocery_store,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              title: const Text('Grocery Store'),
              trailing: const Icon(Icons.close, color: Colors.black,),

            ),
            const Divider(),
          ],
        )
        ,
      ),
    );
  }
}
