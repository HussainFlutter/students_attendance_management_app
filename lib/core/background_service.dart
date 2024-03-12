import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/update_user_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/data/data_source/remote/student_remote_data_source_impl.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/usecase/attendance_status_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/usecase/mark_attendance_usecase.dart';

import '../feature/for_students/data/repo/student_repo_impl.dart';
import '../firebase_options.dart';
import '../main_injection_container.dart';

String globalUid = "";
Future<void> initializeBackgroundService(String uid) async {
  globalUid = uid;
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration:
          IosConfiguration(autoStart: true, onBackground: onIosBackground),
      androidConfiguration: AndroidConfiguration(
        isForegroundMode: false,
        onStart: onStart,
        autoStart: true,
      ));
}

@pragma("vm:entry-point")
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma("vm:entry-point")
void onStart(ServiceInstance service) async {
  try {
    DartPluginRegistrant.ensureInitialized();
    if (service is AndroidServiceInstance) {
      service.on("start_background_service").listen((event) async {
        await service.setAsBackgroundService();
      });
      if (await service.isForegroundService()) {
        customPrint(message: "background service not running");
      } else {
        customPrint(message: "background service running");
        //Initialize firebase
        WidgetsFlutterBinding.ensureInitialized();
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        await initialize();
        AttendanceStatusUseCase(
                repo: StudentRepoImpl(
                    dataSource: StudentRepoRemoteDataSourceImpl()))
            .call(FirebaseAuth.instance.currentUser!.uid)
            .listen((event) async {
          print('Attendance');
          print(event.lastAttendanceAt);
          print(event.attendance);
          print(event.lastAttendanceAt);
          if (event.lastAttendanceAt != null) {
            if (DateUtils.isSameDay(event.lastAttendanceAt, DateTime.now())) {
              print("same day");
            }
            //If its not the same day then we check the attendance bool and change
            // it accordingly
            else {
              // We change the student attendance to false so he/she can
              // mark his/her attendance again.
              if (event.attendance == true) {
                print("updating user");
                await sl<UpdateUserUseCase>().call(UserEntity(
                  attendance: false,
                  lastAttendanceAt: DateTime.now(),
                  uid: event.uid!,
                ));
              } else {
                print("marking attendance");
                //We mark his/her attendance as false and save
                // it to our data base
                await sl<MarkAttendanceUseCase>().call(
                  attendance: false,
                  uid: event.uid!,
                  name: event.name!,
                  email: event.email!,
                );
              }
            }
          }
        });
      }
    }
  } catch (e) {
    customPrint(message: e.toString());
  }
}
