import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:turfnest_admin/Dashboard.dart';
import 'package:turfnest_admin/Menu.dart';
import 'package:turfnest_admin/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: const <Widget>[
            Dashboard(),
            Menu(),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.scbgd,
          buttonBackgroundColor: AppColors.blue,
          color: AppColors.blue,
          height: 0.05 * screenHeight,
          animationCurve: Curves.easeIn,
          items: const <Widget>[
            Icon(
              Icons.dashboard_outlined,
              size: 35,
              color: AppColors.white,
            ),
            Icon(
              Icons.menu_open_sharp,
              size: 35,
              color: AppColors.white,
            ),
          ],
          onTap: (index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          },
        ),
      ),
    );
  }
}
