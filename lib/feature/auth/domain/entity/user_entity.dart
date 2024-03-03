import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final DateTime? createAt;
  final DateTime? lastAttendanceAt;
  final bool? attendance;
  final bool? admin;
  final String? profilePic;
  const UserEntity({
    this.attendance,
    this.email,
    this.uid,
    this.name,
    this.createAt,
    this.lastAttendanceAt,
    this.admin,
    this.profilePic,
  });

  @override
  List<Object?> get props => [
        attendance,
        uid,
        name,
        createAt,
        lastAttendanceAt,
        admin,
        profilePic,
        email,
      ];
}
