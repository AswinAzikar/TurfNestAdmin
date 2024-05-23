import 'package:flutter/material.dart';

import 'constants.dart';

Widget buildProfileButton({
  required IconData icon,
  required String label,
  required VoidCallback onPressed,
}) {
  Color textColor = AppColors.white;
  Color startColor = label == 'Turf Controls' || label == 'Turf History'
      ? AppColors.darkblue
      : AppColors.darkred;
  Color endColor = label == 'Turf Controls' || label == 'Turf History'
      ? AppColors.blue
      : AppColors.red;

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
      gradient: LinearGradient(
        colors: [
          startColor,
          endColor,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: AppColors.white,
              ),
              SizedBox(height: 08),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
