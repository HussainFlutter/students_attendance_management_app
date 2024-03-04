import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/usecase/mark_grade_usecase.dart';

import '../../../../main_injection_container.dart';
import '../../../auth/domain/entity/user_entity.dart';
import '../../../auth/domain/usecases/update_user_usecase.dart';
import '../../domain/usecase/apply_for_leave_usecase.dart';
import '../../domain/usecase/attendance_status_usecase.dart';
import '../../domain/usecase/get_student_attendance_usecase.dart';
import '../../domain/usecase/mark_attendance_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApplyForLeaveUseCase applyForLeave;
  final AttendanceStatusUseCase attendanceStatus;
  final GetStudentAttendanceUseCase getStudentAttendance;
  final MarkGradeUseCase markGrade;
  final MarkAttendanceUseCase markAttendance;
  HomeBloc({
    required this.markGrade,
    required this.markAttendance,
    required this.getStudentAttendance,
    required this.attendanceStatus,
    required this.applyForLeave,
  }) : super(HomeInitial()) {
    on<MarkAttendanceEvent>((event, emit) => _markAttendance(event));
    on<CheckAttendanceEvent>((event, emit) => _checkAttendance(event));
    on<SendApplicationEvent>((event, emit) => _sendApplication(event));
    on<MarkGradeEvent>((event, emit) => _markGrade(event));
  }
  _markGrade(
    MarkGradeEvent event,
  ) async {
    try {
      await markGrade(uid: event.uid);
    } on FirebaseFirestore catch (e) {
      toast(message: e.toString());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  _markAttendance(
    MarkAttendanceEvent event,
  ) async {
    try {
      await markAttendance(
        email: event.email,
        name: event.name,
        uid: event.uid,
        attendance: true,
      );
    } on FirebaseFirestore catch (e) {
      toast(message: e.toString());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  _checkAttendance(
    CheckAttendanceEvent event,
  ) {
    try {
      attendanceStatus.call(event.uid).listen((event) async {
        if (event.lastAttendanceAt != null) {
          if (DateUtils.isSameDay(event.lastAttendanceAt, DateTime.now())) {
          }
          //If its not the same day then we check the attendance bool and change
          // it accordingly
          else {
            // We change the student attendance to false so he/she can
            // mark his/her attendance again.
            if (event.attendance == true) {
              await sl<UpdateUserUseCase>().call(UserEntity(
                attendance: false,
                lastAttendanceAt: DateTime.now(),
                uid: event.uid!,
              ));
            } else {
              //We mark his/her attendance as false and save
              // it to our data base
              await markAttendance.call(
                email: event.email!,
                attendance: false,
                uid: event.uid!,
                name: event.name!,
              );
            }
          }
        }
      });
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  _sendApplication(
    SendApplicationEvent event,
  ) async {
    try {
      await applyForLeave(
        ApplicationEntity(
          uid: event.uid,
          name: event.name,
          paragraph: event.paragraph,
          email: event.email,
        ),
      ).then((value) {
        toast(
          message: "Application sent wait for approval",
          backGroundColor: Colors.green,
        );
        Navigator.pop(event.context);
      });
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }
}
