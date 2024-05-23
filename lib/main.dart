import 'package:flutter/material.dart';
import 'package:turfnest_admin/SignUp.dart';
import 'package:turfnest_admin/HomeScreen.dart';

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
        '/': (context) => SignUpPage(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
