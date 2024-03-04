import 'package:equatable/equatable.dart';

enum Grades { A, B, C, D, E, F }

extension Grading on String {
  Grades? toGrade() {
    switch (this) {
      case "Grades.A":
        return Grades.A;
      case "Grades.B":
        return Grades.B;
      case "Grades.C":
        return Grades.C;
      case "Grades.D":
        return Grades.D;
      case "Grades.E":
        return Grades.E;
      case "Grades.F":
        return Grades.F;
      default:
        return null;
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
