import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../main_injection_container.dart';
import '../../../../z_global_widgets/custon_button.dart';
import '../../domain/usecase/attendance_status_usecase.dart';
import '../bloc/home_bloc.dart';

class ShowAttendanceStatus extends StatefulWidget {
  final String uid;
  final String name;
  const ShowAttendanceStatus(
      {super.key, required this.uid, required this.name});

  @override
  State<ShowAttendanceStatus> createState() => _ShowAttendanceStatusState();
}

class _ShowAttendanceStatusState extends State<ShowAttendanceStatus> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<AttendanceStatusUseCase>().call(widget.uid),
      builder: (context, snapshot) {
        // Checking if the connection is active
        if (snapshot.connectionState == ConnectionState.active) {
          // then showing attendance status
          if (snapshot.data == true) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(("Attendance Marked  ")),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
              ],
            );
          } else {
            return Column(
              children: [
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
                CustomButton(
                    title: "Mark Attendance",
                    onTap: () {
                      context.read<HomeBloc>().add(MarkAttendanceEvent(
                          name: widget.name, uid: widget.uid));
                    }),
              ],
            );
          }
        } else if (snapshot.connectionState == ConnectionState.none) {
          return const Center(
              child: Text(
            "No internet connection",
            style: TextStyle(color: Colors.red),
          ));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
