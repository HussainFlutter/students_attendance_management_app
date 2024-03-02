import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  final String? uid;
  final String? name;
  final DateTime? createAt;
  final DateTime? lastAttendanceAt;
  final bool? attendance;

  const UserModel({
    this.attendance,
    this.uid,
    this.name,
    this.createAt,
    this.lastAttendanceAt,
  }) : super(
          attendance: attendance,
          uid: uid,
          name: name,
          createAt: createAt,
          lastAttendanceAt: lastAttendanceAt,
        );

  factory UserModel.fromSnapshot(Map<String, dynamic> data) {
    return UserModel(
      createAt: data["createAt"].toDate(),
      lastAttendanceAt: data["lastAttendanceAt"].toDate(),
      name: data["name"],
      uid: data["uid"],
      attendance: data["attendance"],
    );
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}
