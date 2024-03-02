import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:students_attendance_management_app/core/constants.dart';

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
  final MarkAttendanceUseCase markAttendance;
  HomeBloc({
    required this.markAttendance,
    required this.getStudentAttendance,
    required this.attendanceStatus,
    required this.applyForLeave,
  }) : super(HomeInitial()) {
    on<MarkAttendanceEvent>((event, emit) => _markAttendance(event));
  }
  _markAttendance(
    MarkAttendanceEvent event,
  ) async {
    try {
      await markAttendance(name: event.name, uid: event.uid);
    } on FirebaseFirestore catch (e) {
      toast(message: e.toString());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }
}
