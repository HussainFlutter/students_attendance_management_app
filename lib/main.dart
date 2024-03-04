import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/config/on_generate_route.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/admin/presentation/bloc/admin_bloc.dart';
import 'package:students_attendance_management_app/feature/admin/presentation/bloc/get_all_students_attendance_bloc.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:students_attendance_management_app/main_injection_container.dart';

import 'feature/for_students/presentation/bloc/home_bloc.dart';
import 'firebase_options.dart';

// BIG BUG : if the student does not login everyday then the app cannot register his/her attendance
// i will try to fix this using background services but for now i left it like this
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<SplashBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<HomeBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<AdminBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<GetAllStudentsAttendanceBloc>(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Student Attendance',
          theme: ThemeData.light(useMaterial3: true),
          initialRoute: RouteConsts.splashScreen,
          onGenerateRoute: onGenerate,
        ),
      ),
    );
  }
}
