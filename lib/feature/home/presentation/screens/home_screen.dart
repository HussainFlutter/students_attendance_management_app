import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              0.2.sizeH(context),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(("Attendance Marked  ")),
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(("Attendance not Marked  ")),
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ],
              ),
              CustomButton(title: "Mark Attendance", onTap: () {}),
              CustomButton(title: "Write Leave", onTap: () {}),
              CustomButton(title: "View Attendance", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
