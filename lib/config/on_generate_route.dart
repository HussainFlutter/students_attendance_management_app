import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/admin/presentation/screens/admin_screen.dart';
import 'package:students_attendance_management_app/feature/admin/presentation/screens/view_logged_in_students.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/login_screen.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/profile_screen.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/signup_screen.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/splash_screen.dart';
import 'package:students_attendance_management_app/feature/for_students/presentation/screens/view_attendance.dart';
import 'package:students_attendance_management_app/feature/for_students/presentation/screens/write_application.dart';

import '../feature/admin/presentation/screens/view_leave_applications.dart';
import '../feature/admin/presentation/screens/view_student_attendance.dart';
import '../feature/for_students/presentation/screens/home_screen.dart';

Route onGenerate(RouteSettings settings) {
  switch (settings.name) {
    //Student only Screens
    case RouteConsts.writeApplication:
      final Map<String, String?> data =
          settings.arguments as Map<String, String?>;
      return MaterialPageRoute(
          builder: (context) => WriteApplicationScreen(
                name: data["name"]!,
                uid: data["uid"]!,
                email: data["email"]!,
              ));
    case RouteConsts.home:
      return MaterialPageRoute(
          builder: (context) =>
              HomeScreen(currentUser: settings.arguments as UserEntity));
    case RouteConsts.viewMyAttendance:
      return MaterialPageRoute(
          builder: (context) =>
              ViewAttendanceScreen(uid: settings.arguments as String));
    //Admin only Screens
    case RouteConsts.adminScreen:
      return MaterialPageRoute(
          builder: (context) =>
              AdminScreen(userEntity: settings.arguments as UserEntity));
    case RouteConsts.loggedInStudentsScreen:
      return MaterialPageRoute(
          builder: (context) => const ViewLoggedInStudentsScreen());
    case RouteConsts.viewApplications:
      return MaterialPageRoute(
          builder: (context) => const ViewApplicationsScreen());
    case RouteConsts.viewAllAttendance:
      return MaterialPageRoute(
          builder: (context) => const ViewStudentsAttendance());
    //Global Screens
    case RouteConsts.login:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case RouteConsts.profileScreen:
      return MaterialPageRoute(
          builder: (context) =>
              ProfileScreen(uid: settings.arguments as String));
    case RouteConsts.signUp:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case RouteConsts.splashScreen:
      return MaterialPageRoute(builder: (context) => const SplashScreen());
    default:
      return MaterialPageRoute(builder: (context) => const NoPageFound());
  }
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("No Page Found"),
      ),
    );
  }
}
