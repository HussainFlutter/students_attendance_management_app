import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../widgets/show_attendance_status.dart';

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
              ShowAttendanceStatus(
                uid: widget.currentUser.uid!,
                name: widget.currentUser.name!,
              ),
              CustomButton(title: "Write Leave", onTap: () {}),
              CustomButton(title: "View Attendance", onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
