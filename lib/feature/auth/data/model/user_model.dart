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

  const UserModel({
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
        );

  factory UserModel.fromSnapshot(Map<String, dynamic> data) {
    return UserModel(
      createAt: data["createAt"].toDate(),
      lastAttendanceAt: data["lastAttendanceAt"]?.toDate(),
      name: data["name"],
      uid: data["uid"],
      attendance: data["attendance"],
      admin: data["admin"],
      profilePic: data["profilePic"],
      email: data["email"],
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
    };
  }
}
