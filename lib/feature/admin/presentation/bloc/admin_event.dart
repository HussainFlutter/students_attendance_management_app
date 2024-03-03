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
