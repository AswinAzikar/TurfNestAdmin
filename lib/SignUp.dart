import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:turfnest_admin/HomeScreen.dart';
import 'package:turfnest_admin/constants.dart';
import 'package:turfnest_admin/firebase_helper/auth_helper/auth_helper.dart';
import 'package:turfnest_admin/firebase_helper/firestore_helper/firestore_helper.dart';
import 'package:turfnest_admin/login.dart';
import 'package:turfnest_admin/routes.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late String _ownerName = '',
      _ownerEmail = '',
      _ownerPassword = '',
      _ownerLocation = '';

  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      bool a = await FirebaseFirestoreHelper.instance.isAdminCollectionEmpty();
      if (a) {
        bool issignup = await FirebaseAuthHelper.instance.signup(
          context,
          _ownerName,
          _ownerEmail,
          _ownerLocation,
          _ownerPassword,
        );

        if (issignup) {
          Routes.instance.push(HomeScreen(), context);
        }
      } else {
        showCustomDialog(
          context: context,
          content: "Registration limit reached",
          buttonText: "ok",
          navigateFrom: LoginPage(),
          title: "Warning"
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.blue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                FadeTransition(
                  opacity: _animation,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Turf Owner Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onSaved: (value) => _ownerName = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                FadeTransition(
                  opacity: _animation,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Turf Owner Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onSaved: (value) => _ownerEmail = value!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                FadeTransition(
                  opacity: _animation,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          onSaved: (value) => _ownerPassword = value!,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      Expanded(
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                FadeTransition(
                  opacity: _animation,
                  child: TextFormField(
                    readOnly: true,
                    controller: _locationController,
                    decoration: InputDecoration(
                      labelText: 'Location of the Turf',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: ElevatedButton(
                        onPressed: () async {
                          await getcurrentlocation(context);
                        },
                        child: Icon(Icons.gps_fixed, color: AppColors.blue),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: AppColors.blue,
                          backgroundColor: AppColors.white,
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                        ),
                      ),
                    ),
                    onSaved: (value) => _ownerLocation = _locationController.text,
                    validator: (value) {
                      if (_locationController.text.isEmpty) {
                        return 'Please get the location';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                FadeTransition(
                  opacity: _animation,
                  child: ElevatedButton(
                    onPressed: _signUp,
                    child: Text('Sign Up'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getcurrentlocation(BuildContext context) async {
    ShowLoaderDialog(context);
    await Geolocator.checkPermission();
    LocationPermission ask = await Geolocator.requestPermission();

    Position currentposition = await Geolocator.getCurrentPosition();

    LatLng a = LatLng(currentposition.latitude, currentposition.longitude);
    String location = await getPlaceFromLatLng(a);
    Navigator.pop(context);

    setState(() {
      _locationController.text = location;
    });
  }

  Future<String> getPlaceFromLatLng(LatLng latLng) async {
    try {
      final locations =
          await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (locations.isNotEmpty) {
        final placemark = locations.first;

        return placemark.locality ?? '';
      } else {
        print('No results found for ${latLng.latitude}, ${latLng.longitude}');
        return "No results found";
      }
    } catch (e) {
      print('Error fetching place: $e');
      return "Error fetching location";
    }
  }
}
