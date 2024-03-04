import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';

import '../../../../main_injection_container.dart';
import '../../../for_students/domain/usecase/attendance_status_usecase.dart';
import '../bloc/auth_bloc/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({super.key, required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent(context: context));
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream: sl<AttendanceStatusUseCase>().call(widget.uid),
          builder: (context, snapshot) {
            // Checking if the connection is active
            if (snapshot.connectionState == ConnectionState.active) {
              // then showing attendance status
              if (snapshot.data != null) {
                final data = snapshot.data;
                return Column(
                  children: [
                    Hero(
                      tag: "1",
                      child: CircleAvatar(
                        radius: 0.08.mediaH(context),
                        backgroundImage: data?.profilePic == null ||
                                data!.profilePic!.isEmpty
                            ? const AssetImage("assets/images/logo.jpg")
                                as ImageProvider<Object>?
                            : CachedNetworkImageProvider(data.profilePic!)
                                as ImageProvider<Object>?,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(PickImageEvent(uid: widget.uid));
                            },
                          ),
                        ),
                      ),
                    ),
                    0.02.sizeH(context),
                    Text("Name: ${data!.name}"),
                    data.grade == null
                        ? const SizedBox()
                        : Text("Grade: ${data.grade}"),
                  ],
                );
              } else {
                return const Center(
                  child: Text(
                    "Failed to load profile",
                    style: TextStyle(color: Colors.red),
                  ),
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
        ),
      ),
    );
  }
}
