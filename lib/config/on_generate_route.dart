import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/login_screen.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/signup_screen.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/screens/splash_screen.dart';

import '../feature/for_students/presentation/screens/home_screen.dart';

Route onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case RouteConsts.home:
      return MaterialPageRoute(
          builder: (context) =>
              HomeScreen(currentUser: settings.arguments as UserEntity));
    case RouteConsts.login:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
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
