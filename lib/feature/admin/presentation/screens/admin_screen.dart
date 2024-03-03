import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

class AdminScreen extends StatefulWidget {
  final UserEntity userEntity;
  const AdminScreen({super.key, required this.userEntity});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    String? profilePic = widget.userEntity.profilePic;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteConsts.profileScreen,
                arguments: widget.userEntity.uid,
              );
            },
            child: Hero(
              tag: "1",
              transitionOnUserGestures: true,
              child: CircleAvatar(
                backgroundImage: profilePic == null || profilePic.isEmpty
                    ? const AssetImage("assets/images/logo.jpg")
                        as ImageProvider<Object>?
                    : CachedNetworkImageProvider(profilePic)
                        as ImageProvider<Object>?,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0.1.mediaW(context),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(title: "Create Specific user report", onTap: () {}),
              0.02.sizeH(context),
              CustomButton(title: "Create system report", onTap: () {}),
              0.02.sizeH(context),
              CustomButton(
                  title: "View all logged in Students",
                  onTap: () => Navigator.pushNamed(
                        context,
                        RouteConsts.loggedInStudentsScreen,
                      )),
              0.02.sizeH(context),
              CustomButton(
                  title: "View Students Attendance",
                  onTap: () => Navigator.pushNamed(
                        context,
                        RouteConsts.viewAllAttendance,
                      )),
              0.02.sizeH(context),
              CustomButton(
                  title: "View Leave Applications",
                  onTap: () => Navigator.pushNamed(
                        context,
                        RouteConsts.viewApplications,
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
