import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../../../../for_students/domain/entity/attendance_entity.dart';
import '../../bloc/admin_bloc.dart';

class EditAttendanceScreen extends StatefulWidget {
  final AttendanceEntity attendance;
  const EditAttendanceScreen({super.key, required this.attendance});

  @override
  State<EditAttendanceScreen> createState() => _EditAttendanceScreenState();
}

class _EditAttendanceScreenState extends State<EditAttendanceScreen> {
  late String defaultValue;
  @override
  void initState() {
    super.initState();
    defaultValue = widget.attendance.attendance.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
                value: defaultValue,
                items: const [
                  DropdownMenuItem(value: "true", child: Text("true")),
                  DropdownMenuItem(value: "false", child: Text("false")),
                ],
                onChanged: (value) {
                  if (value == "true") {
                    setState(() {
                      defaultValue = "true";
                    });
                  } else {
                    setState(() {
                      defaultValue = "false";
                    });
                  }
                }),
            0.1.sizeH(context),
            CustomButton(
              title: "Edit",
              onTap: () {
                context.read<AdminBloc>().add(UpdateAttendanceEvent(
                      attendanceEntity: AttendanceEntity(
                        attendance: defaultValue == "true" ? true : false,
                        uid: widget.attendance.uid,
                        id: widget.attendance.id,
                      ),
                    ));
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
