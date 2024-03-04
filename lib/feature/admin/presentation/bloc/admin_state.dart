part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();
  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {}

class AdminLoading extends AdminState {}

class AdminLoaded extends AdminState {
  final List<AttendanceEntity> attendanceList;

  const AdminLoaded({required this.attendanceList});
  @override
  List<Object> get props => [attendanceList];
}
