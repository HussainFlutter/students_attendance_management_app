import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/from_to_date_student_attendance.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

import '../../domain/usecase/add_attendance_usecase.dart';
import '../../domain/usecase/delete_attendance_usecase.dart';
import '../../domain/usecase/update_attendance_usecase.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final DeleteAttendanceUseCase deleteAttendance;
  final UpdateAttendanceUseCase updateAttendance;
  final AddAttendanceUseCase addAttendance;
  final FromToDateStudentAttendanceUseCase fromToDateStudentAttendance;
  AdminBloc({
    required this.deleteAttendance,
    required this.updateAttendance,
    required this.addAttendance,
    required this.fromToDateStudentAttendance,
  }) : super(AdminInitial()) {
    on<DeleteAttendanceEvent>((event, emit) => _deleteAttendance(event));
    on<UpdateAttendanceEvent>((event, emit) => _updateAttendance(event));
    on<AddAttendanceEvent>((event, emit) => _addAttendance(event));
    on<FromToDateStudentAttendanceEvent>(
        (event, emit) => _fromToDateStudentAttendance(event, emit));
  }
  Future<void> _deleteAttendance(
    DeleteAttendanceEvent event,
  ) async {
    try {
      await deleteAttendance(id: event.docId, uid: event.uid);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  Future<void> _updateAttendance(
    UpdateAttendanceEvent event,
  ) async {
    try {
      await updateAttendance(attendance: event.attendanceEntity);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  Future<void> _addAttendance(
    AddAttendanceEvent event,
  ) async {
    try {
      await addAttendance(attendance: event.attendance, email: event.email);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  Future<void> _fromToDateStudentAttendance(
    FromToDateStudentAttendanceEvent event,
    Emitter<AdminState> emit,
  ) async {
    try {
      emit(AdminLoading());
      await fromToDateStudentAttendance(
        email: event.email,
        fromDate: event.fromDate,
        toDate: event.toDate,
      ).then((value) {
        emit(AdminLoaded(attendanceList: value));
      }).onError((error, stackTrace) {
        emit(AdminInitial());
      });
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }
}
