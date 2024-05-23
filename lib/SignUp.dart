import 'package:flutter/material.dart';
import 'package:turfnest_admin/constants.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late String _ownerName = '',
      _ownerEmail = '',
      _ownerPassword = '',
      _ownerConfirmPassword = '',
      _ownerLocation = '';
  bool _isLoading = false;
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
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // Perform sign-up logic here
      Navigator.pushReplacementNamed(context, '/home');
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
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              FadeTransition(
                opacity: _animation,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
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
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        onSaved: (value) => _ownerConfirmPassword = value!,
                        obscureText: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              FadeTransition(
                opacity: _animation,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Location of the Turf',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: ElevatedButton(
                      onPressed: () {
                        // Add code here to get location using GPS
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
                  onSaved: (value) => _ownerLocation = value!,
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
    );
  }
}
