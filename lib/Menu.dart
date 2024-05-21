import 'package:flutter/material.dart';
import 'package:turfnest_admin/Dashboard.dart';

import 'package:turfnest_admin/constants.dart';

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
    return Scaffold(
      backgroundColor: AppColors.scbgd,
      appBar: AppBar(
        title: Text(
          "Menu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.scbgd,
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
            ),
            iconSize: 32,
            onPressed: () {
              // Handle user icon button press
            },
          ),
        ],
      ),
    );
  }
}
