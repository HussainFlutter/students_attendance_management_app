import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

import '../../domain/usecase/delete_attendance_usecase.dart';
import '../../domain/usecase/update_attendance_usecase.dart';

part 'admin_event.dart';
part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final DeleteAttendanceUseCase deleteAttendance;
  final UpdateAttendanceUseCase updateAttendance;
  AdminBloc({
    required this.deleteAttendance,
    required this.updateAttendance,
  }) : super(AdminInitial()) {
    on<DeleteAttendanceEvent>((event, emit) => _deleteAttendance(event));
    on<UpdateAttendanceEvent>((event, emit) => _updateAttendance(event));
  }
  _deleteAttendance(
    DeleteAttendanceEvent event,
  ) async {
    try {
      await deleteAttendance(id: event.docId, uid: event.uid);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  _updateAttendance(
    UpdateAttendanceEvent event,
  ) async {
    try {
      await updateAttendance(attendance: event.attendanceEntity);
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }
}
