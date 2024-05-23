import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:turfnest_admin/Dashboard.dart';
import 'package:turfnest_admin/Menu.dart';
import 'package:turfnest_admin/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
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
            size: 34,
            color: AppColors.white,
          ),
        ],
        index: _pageIndex,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
