part of 'get_all_students_attendance_bloc.dart';

abstract class GetAllStudentsAttendanceEvent extends Equatable {
  const GetAllStudentsAttendanceEvent();
}

class GetAllStudentAttendances extends GetAllStudentsAttendanceEvent {
  final DateTime toDate;
  final DateTime fromDate;

  const GetAllStudentAttendances(
      {required this.toDate, required this.fromDate});

  @override
  List<Object?> get props => [toDate, fromDate];
}
