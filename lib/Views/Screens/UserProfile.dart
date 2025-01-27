import 'package:flutter/material.dart';

import '../Utils/utils.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {

  String _fullName = "";
  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  // Load full name from SharedPreferences
  Future<void> _loadFullName() async {
    String? fullName = await fetchName();
    setState(() {
      _fullName = fullName!;
    });
  }


  Future<String?> fetchName() async {
    // Try to get the full name saved in shared preferences
    String? fullName = await Utils.getString("name"); // 'name' is the key for the full name

    if (fullName != null && fullName.isNotEmpty) {
      // If full name is found, return it
      return fullName;
    } else {

      return fullName!.isEmpty ? "Armughan Tallat Khan" : fullName;
    }
  }

  // You can later use this to manage state such as user information
  String name = 'Abdur Rehman';
  String email = 'johndoe@example.com';
  String phoneNumber = '030*******90';
  String password = '************';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Circle Avatar for the Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blue[900],
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            // Name Display
            Text(
              _fullName,
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Edit Profile Button
            GestureDetector(
              onTap: () {
                // Handle Edit Profile
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blue[900],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Email Container
            _buildProfileContainer(
              icon: Icons.email,
              title: 'Email Address',
              value: email,
              isVerified: false,  // You can update this value dynamically
            ),
            const SizedBox(height: 20),

            // Phone Number Container
            _buildProfileContainer(
              icon: Icons.phone,
              title: 'Phone Number',
              value: phoneNumber,
              isVerified: false,  // Update as needed
            ),
            const SizedBox(height: 20),

            // Password Container
            _buildProfileContainer(
              icon: Icons.lock,
              title: 'Password',
              value: password,
              isVerified: true,  // Password verification can be handled later if needed
            ),
            const SizedBox(height: 40),

            // Delete Account Text
            const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Delete Account',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom Widget for Profile Info Containers
  Widget _buildProfileContainer({
    required IconData icon,
    required String title,
    required String value,
    required bool isVerified,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              if (!isVerified)
                const Text(
                  'Unverified',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
