import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? name;
  final DateTime? createAt;
  final DateTime? lastAttendanceAt;
  final bool? attendance;
  final bool? admin;

  const UserModel({
    this.attendance,
    this.uid,
    this.admin,
    this.name,
    this.createAt,
    this.lastAttendanceAt,
  }) : super(
          attendance: attendance,
          uid: uid,
          name: name,
          createAt: createAt,
          lastAttendanceAt: lastAttendanceAt,
          admin: admin,
        );

  factory UserModel.fromSnapshot(Map<String, dynamic> data) {
    return UserModel(
      createAt: data["createAt"].toDate(),
      lastAttendanceAt: data["lastAttendanceAt"]?.toDate(),
      name: data["name"],
      uid: data["uid"],
      attendance: data["attendance"],
      admin: data["admin"],
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
    };
  }
}
