import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final DateTime? createAt;
  final DateTime? lastAttendanceAt;
  final bool? attendance;
  final bool? admin;

  const UserEntity({
    this.attendance,
    this.uid,
    this.name,
    this.createAt,
    this.lastAttendanceAt,
    this.admin,
  });

  @override
  List<Object?> get props =>
      [attendance, uid, name, createAt, lastAttendanceAt, admin];
}
