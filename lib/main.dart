import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:students_attendance_management_app/config/on_generate_route.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:students_attendance_management_app/main_injection_container.dart';

import 'feature/for_students/presentation/bloc/home_bloc.dart';
import 'firebase_options.dart';

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
