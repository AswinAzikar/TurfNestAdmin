import 'package:flutter/material.dart';

import 'package:turfnest_admin/Menu.dart';
import 'package:turfnest_admin/Sports/sports.dart';

import 'package:turfnest_admin/constants.dart';

import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';

class AddGame extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<AddGame> {
  final _formKey = GlobalKey<FormState>();
  late String game = '', price = '';
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      await FirebaseFirestoreHelper.instance.addgame(game, price);
      showCustomDialog(
          context: context,
          content: "sport added sucessfully",
          buttonText: "ok",
          navigateFrom: Menu(),
          title: "NOTE");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.scbgd,
      appBar: AppBar(
        backgroundColor: AppColors.scbgd,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.blue,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SportsPage(),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Red header section
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    'Add Sport',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                // White form section
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Sports Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onSaved: (value) => game = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Sports Name';
                          }
                          game = value;
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'price',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onSaved: (value) => price = value!,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter price';
                          }
                          price = value;
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      ElevatedButton(
                        onPressed: _login,
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text('Add'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: AppColors.blue,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.25,
                            vertical: 15.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
