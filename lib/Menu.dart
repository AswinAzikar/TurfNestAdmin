import 'package:flutter/material.dart';
import 'package:turfnest_admin/FeedbackScreen.dart';
import 'package:turfnest_admin/Sports/sports.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/custom.dart';
import 'package:turfnest_admin/routes.dart';
import 'package:turfnest_admin/turfcontrol/TurfControl.dart';

import 'Dashboard.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  void onToggle(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Menu()),
        );
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scbgd,
      appBar: AppBar(
        title: const Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.scbgd,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle,
            ),
            iconSize: 32,
            onPressed: () {
              // Handle user icon button press
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: screenWidth / (screenHeight * 0.5),
          children: [
            buildProfileButton(
              icon: Icons.settings,
              label: 'Turf Controls',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TurfControlPage(),
                  ),
                );
              },
            ),
            buildProfileButton(
              icon: Icons.sports_soccer,
              label: 'Sports',
              onPressed: () {
                Routes.instance.push(SportsPage(), context);
              },
            ),
            buildProfileButton(
                icon: Icons.feedback,
                label: 'Feedback',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedbackPage(),
                    ),
                  );
                }),
            buildProfileButton(
                icon: Icons.history_sharp,
                label: 'Turf History',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FeedbackPage(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
