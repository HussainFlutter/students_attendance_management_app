part of 'get_all_students_attendance_bloc.dart';

abstract class GetAllStudentsAttendanceState extends Equatable {
  const GetAllStudentsAttendanceState();
  @override
  List<Object> get props => [];
}

class GetAllStudentsAttendanceInitial extends GetAllStudentsAttendanceState {
  @override
  List<Object> get props => [];
}

class GetAllStudentsAttendanceLoading extends GetAllStudentsAttendanceState {}

class GetAllStudentsAttendanceLoaded extends GetAllStudentsAttendanceState {
  final List<AttendanceEntity> attendanceList;

  const GetAllStudentsAttendanceLoaded({required this.attendanceList});
  @override
  List<Object> get props => [attendanceList];
}
