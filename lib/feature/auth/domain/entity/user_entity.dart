import 'package:equatable/equatable.dart';

enum Grades { A, B, C, D, E, F }

extension Grading on String {
  Grades toGrade() {
    switch (this) {
      case "A":
        return Grades.A;
      case "B":
        return Grades.B;
      case "C":
        return Grades.C;
      case "D":
        return Grades.D;
      case "E":
        return Grades.E;
      default:
        return Grades.F;
    }
  }
}

class UserEntity extends Equatable {
  final String? uid;
  final String? name;
  final String? email;
  final DateTime? createAt;
  final DateTime? lastAttendanceAt;
  final bool? attendance;
  final bool? admin;
  final String? profilePic;
  final int? attendedDays;
  final DateTime? lastGradedAt;
  final Grades? grade;
  const UserEntity({
    this.attendedDays,
    this.lastGradedAt,
    this.grade,
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
        grade,
        lastGradedAt,
        attendedDays,
      ];
}
