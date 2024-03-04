import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/z_global_widgets/custon_button.dart';

import '../bloc/home_bloc.dart';
import '../widgets/show_attendance_status.dart';

class HomeScreen extends StatefulWidget {
  final UserEntity currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void initialize() async {
  //   if (await FlutterBackgroundService().isRunning()) {
  //   } else {
  //     await initializeBackgroundService(widget.currentUser.uid!);
  //   }
  // }

  @override
  void initState() {
    // initialize();
    // FlutterBackgroundService().invoke("start_background_service");
    super.initState();
    context.read<HomeBloc>().add(CheckAttendanceEvent(
        email: widget.currentUser.email!, uid: widget.currentUser.uid!));
    context.read<HomeBloc>().add(MarkGradeEvent(uid: widget.currentUser.uid!));
  }

  String? profilePic;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteConsts.profileScreen,
                arguments: widget.currentUser.uid,
              );
            },
            child: Hero(
              tag: "1",
              transitionOnUserGestures: true,
              child: CircleAvatar(
                backgroundImage: profilePic == null || profilePic!.isEmpty
                    ? const AssetImage("assets/images/logo.jpg")
                        as ImageProvider<Object>?
                    : CachedNetworkImageProvider(profilePic!)
                        as ImageProvider<Object>?,
              ),
            ),
          ),
          0.02.sizeW(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              0.2.sizeH(context),
              ShowAttendanceStatus(
                email: widget.currentUser.email!,
                profilePic: (value) {
                  profilePic = value;
                },
                uid: widget.currentUser.uid!,
                name: widget.currentUser.name!,
              ),
              CustomButton(
                  title: "Write Leave",
                  onTap: () {
                    Navigator.pushNamed(context, RouteConsts.writeApplication,
                        arguments: {
                          "name": widget.currentUser.name,
                          "uid": widget.currentUser.uid,
                          "email": widget.currentUser.email,
                        });
                  }),
              CustomButton(
                  title: "View Attendance",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RouteConsts.viewMyAttendance,
                      arguments: widget.currentUser.uid!,
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
