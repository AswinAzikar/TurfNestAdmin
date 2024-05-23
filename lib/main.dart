import 'package:flutter/material.dart';
import 'package:turfnest_admin/HomeScreen.dart';
import 'package:turfnest_admin/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
