part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();
}

class DeleteAttendanceEvent extends AdminEvent {
  final String uid;
  final String docId;

  const DeleteAttendanceEvent({required this.uid, required this.docId});
  @override
  List<Object?> get props => [uid, docId];
}

class UpdateAttendanceEvent extends AdminEvent {
  final AttendanceEntity attendanceEntity;

  const UpdateAttendanceEvent({required this.attendanceEntity});
  @override
  List<Object?> get props => [attendanceEntity];
}

class AddAttendanceEvent extends AdminEvent {
  final String email;
  final bool attendance;

  const AddAttendanceEvent({required this.email, required this.attendance});
  @override
  List<Object?> get props => [email, attendance];
}

class FromToDateStudentAttendanceEvent extends AdminEvent {
  final String email;
  final DateTime toDate;
  final DateTime fromDate;

  const FromToDateStudentAttendanceEvent(
      {required this.email, required this.toDate, required this.fromDate});

  @override
  List<Object?> get props => [email, toDate, fromDate];
}
