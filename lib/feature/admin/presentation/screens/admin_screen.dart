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
          child: TweenAnimationBuilder(
            duration: const Duration(milliseconds: 500),
            tween: Tween<Offset>(
                begin: const Offset(1, 0), end: const Offset(0, 0)),
            builder: (context, val, child) {
              return AnimatedSlide(
                offset: val,
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      title: "Search Specific Students ",
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteConsts.searchSpecificUserScreen,
                      ),
                    ),
                    0.02.sizeH(context),
                    CustomButton(
                      title: "Search all Students",
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteConsts.searchAllStudentsScreen,
                      ),
                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}
