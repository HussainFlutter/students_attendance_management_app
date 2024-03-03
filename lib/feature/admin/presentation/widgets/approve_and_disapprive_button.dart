import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';

class ApproveOrDisapprove extends StatelessWidget {
  final VoidCallback onApproveTap;
  final VoidCallback onDisapproveTap;
  final String title1;
  final String title2;
  const ApproveOrDisapprove({
    super.key,
    required this.onApproveTap,
    required this.onDisapproveTap,
    this.title1 = "Approve",
    this.title2 = "Disapprove",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: onApproveTap,
              child: Container(
                height: 50,
                color: Colors.green,
                child: Center(
                    child: Text(
                  title1,
                  style: const TextStyle(color: Colors.white),
                )),
              ),
            ),
          ),
          0.02.sizeW(context),
          Expanded(
            child: InkWell(
              onTap: onDisapproveTap,
              child: Container(
                height: 50,
                color: Colors.red,
                child: Center(
                    child: Text(title2,
                        style: const TextStyle(color: Colors.white))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
