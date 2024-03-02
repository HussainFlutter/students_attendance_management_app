import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: 0.1.mediaW(context),
            vertical: 0.05.mediaH(context),
          ),
        ),
        onPressed: onTap,
        child: Text(title));
  }
}
