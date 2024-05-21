import 'package:flutter/material.dart';
import 'package:turfnest_admin/constants.dart';

class TurfControlPage extends StatefulWidget {
  const TurfControlPage({super.key});

  @override
  State<TurfControlPage> createState() => _TurfControlPageState();
}

class _TurfControlPageState extends State<TurfControlPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turf Control'),
        backgroundColor: AppColors.scbgd,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Turf Control',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Here is where you can control your turf.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.grey,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.control_camera,
                      color: AppColors.white,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Control Turf',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
