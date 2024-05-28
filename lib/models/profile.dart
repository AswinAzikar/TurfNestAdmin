import 'package:flutter/material.dart';
import 'package:turfnest_admin/HomeScreen.dart';
import 'package:turfnest_admin/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.red),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CircleAvatar(
            //   radius: screenWidth * 0.15,
            //   backgroundColor: AppColors.blue,
            //   child: Icon(
            //     Icons.person,
            //     size: screenWidth * 0.15,
            //     color: Colors.white,
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: Text(
                'John Doe',
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Center(
              child: Text(
                'john.doe@example.com',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Divider(color: Colors.grey[400]),
            SizedBox(height: screenHeight * 0.03),
            ListTile(
              leading: Icon(
                Icons.email,
                color: AppColors.red,
              ),
              title: Text(
                'Email',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
              ),
              subtitle: const Text('john.doe@example.com'),
            ),
            SizedBox(height: screenHeight * 0.03),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              ),
              onPressed: () {
                // Implement change password functionality here
              },
              child: const Text('Change Password'),
            ),
            SizedBox(height: screenHeight * 0.02),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
              ),
              onPressed: () {
                // Implement logout functionality here
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
