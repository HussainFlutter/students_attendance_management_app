import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:students_attendance_management_app/core/constants.dart';

import '../../../for_students/domain/entity/attendance_entity.dart';
import '../../domain/usecase/from_to_date_of_all_student_attendance_usecase.dart';

part 'get_all_students_attendance_event.dart';
part 'get_all_students_attendance_state.dart';

class GetAllStudentsAttendanceBloc
    extends Bloc<GetAllStudentsAttendanceEvent, GetAllStudentsAttendanceState> {
  final FromToDateOfAllStudentAttendanceUseCase getAllAttendances;
  GetAllStudentsAttendanceBloc({required this.getAllAttendances})
      : super(GetAllStudentsAttendanceInitial()) {
    on<GetAllStudentAttendances>(
        (event, emit) => _getAllAttendances(event, emit));
  }

  Future<void> _getAllAttendances(
    GetAllStudentAttendances event,
    Emitter<GetAllStudentsAttendanceState> emit,
  ) async {
    try {
      emit(GetAllStudentsAttendanceLoading());
      await getAllAttendances(fromDate: event.fromDate, toDate: event.toDate)
          .then((value) {
        emit(GetAllStudentsAttendanceLoaded(attendanceList: value));
      }).onError((error, stackTrace) {
        emit(GetAllStudentsAttendanceInitial());
      });
    } catch (e) {
      toast(message: e.toString());
    }
  }
}
