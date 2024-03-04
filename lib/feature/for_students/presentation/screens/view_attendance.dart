import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/usecase/get_student_attendance_usecase.dart';

import '../../../../main_injection_container.dart';

class ViewAttendanceScreen extends StatefulWidget {
  final String uid;
  const ViewAttendanceScreen({super.key, required this.uid});

  @override
  State<ViewAttendanceScreen> createState() => _ViewAttendanceScreenState();
}

class _ViewAttendanceScreenState extends State<ViewAttendanceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Attendance"),
      ),
      body: StreamBuilder(
        stream: sl<GetStudentAttendanceUseCase>().call(widget.uid),
        builder: (context, snapshot) {
          // Checking if the connection is active
          if (snapshot.connectionState == ConnectionState.active) {
            // then showing attendance status
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                final data = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: data!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data[index].name!),
                          subtitle: Text(
                            data[index].attendance == true
                                ? "Attended"
                                : "Absent",
                            style: TextStyle(
                              color: data[index].attendance == true
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          trailing: Text(DateFormat("dd-MM-yyyy")
                              .format(data[index].markedAt!)),
                        );
                      }),
                );
              } else {
                return const Center(child: Text("No attendance marked yet"));
              }
            } else {
              return const Center(child: Text("No attendance marked yet"));
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(
                child: Text(
              "No internet connection",
              style: TextStyle(color: Colors.red),
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
