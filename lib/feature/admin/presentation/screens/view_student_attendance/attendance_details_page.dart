import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/admin/presentation/widgets/approve_and_disapprive_button.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

import '../../bloc/admin_bloc.dart';

class AttendanceDetailsPage extends StatefulWidget {
  final AttendanceEntity attendance;
  const AttendanceDetailsPage({super.key, required this.attendance});

  @override
  State<AttendanceDetailsPage> createState() => _AttendanceDetailsPageState();
}

class _AttendanceDetailsPageState extends State<AttendanceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance Details"),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: widget.attendance.attendance == false
                  ? Colors.red
                  : Colors.green,
              child: Text(
                widget.attendance.attendance == false ? "A" : "P",
              ),
            ),
            Text(widget.attendance.name!),
            Text(widget.attendance.email!),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Marked At: "),
                Text(DateFormat("dd-MM-yyyy")
                    .format(widget.attendance.markedAt!)),
              ],
            ),
            ApproveOrDisapprove(
              title1: "Edit",
              title2: "Delete",
              onApproveTap: () {
                //Edit
                Navigator.pushNamed(
                  context,
                  RouteConsts.editAttendanceScreen,
                  arguments: widget.attendance,
                );
              },
              onDisapproveTap: () {
                //Delete
                context.read<AdminBloc>().add(DeleteAttendanceEvent(
                      uid: widget.attendance.uid!,
                      docId: widget.attendance.id!,
                    ));
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
