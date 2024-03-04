import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? name;
  final String? profilePic;
  final DateTime? createAt;
  final DateTime? lastAttendanceAt;
  final bool? attendance;
  final bool? admin;
  final String? email;
  final int? attendedDays;
  final DateTime? lastGradedAt;
  final Grades? grade;
  const UserModel({
    this.attendedDays,
    this.lastGradedAt,
    this.grade,
    this.attendance,
    this.uid,
    this.email,
    this.profilePic,
    this.admin,
    this.name,
    this.createAt,
    this.lastAttendanceAt,
  }) : super(
          attendance: attendance,
          uid: uid,
          name: name,
          profilePic: profilePic,
          createAt: createAt,
          lastAttendanceAt: lastAttendanceAt,
          admin: admin,
          email: email,
          grade: grade,
          lastGradedAt: lastGradedAt,
          attendedDays: attendedDays,
        );

  factory UserModel.fromSnapshot(Map<String, dynamic> data) {
    final String? grade = data["grade"];
    return UserModel(
      createAt: data["createAt"].toDate(),
      lastAttendanceAt: data["lastAttendanceAt"]?.toDate(),
      lastGradedAt: data["lastGradedAt"].toDate(),
      name: data["name"],
      uid: data["uid"],
      attendance: data["attendance"],
      admin: data["admin"],
      profilePic: data["profilePic"],
      email: data["email"],
      grade: grade?.toGrade(),
      attendedDays: data["attendedDays"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "lastAttendanceAt": lastAttendanceAt,
      "createAt": createAt,
      "uid": uid,
      "attendance": attendance,
      "admin": admin,
      "profilePic": profilePic,
      "email": email,
      "grade": grade.toString(),
      "attendedDays": attendedDays,
      "lastGradedAt": lastGradedAt,
    };
  }
}
