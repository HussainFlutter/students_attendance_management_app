import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_student_attendances_usecase.dart';

import '../../../../main_injection_container.dart';

class ViewStudentsAttendance extends StatefulWidget {
  const ViewStudentsAttendance({super.key});

  @override
  State<ViewStudentsAttendance> createState() => _ViewStudentsAttendanceState();
}

class _ViewStudentsAttendanceState extends State<ViewStudentsAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students Attendance"),
      ),
      body: StreamBuilder(
        stream: sl<GetAllAttendancesUseCase>().call(),
        builder: (context, snapshot) {
          // Checking if the connection is active
          if (snapshot.connectionState == ConnectionState.active) {
            // then showing Logged in students
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Attendances yet"),
              );
            } else {
              final data = snapshot.data;
              return ListView.builder(
                  itemCount: data!.length,
                  itemBuilder: (context, index) {
                    final indexData = data[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: indexData.attendance == false
                            ? Colors.red
                            : Colors.green,
                        child: Text(
                          indexData.attendance == false ? "A" : "P",
                        ),
                      ),
                      title: Text(indexData.name!),
                      subtitle: Text(indexData.email!),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Marked At"),
                          Text(DateFormat("dd-MM-yyyy")
                              .format(indexData.markedAt!)),
                        ],
                      ),
                    );
                  });
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
