import 'package:students_attendance_management_app/feature/for_students/home/domain/entity/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  final String? id;
  final String? uid;
  final DateTime? markedAt;
  final String? name;

  const AttendanceModel({
    this.id,
    this.uid,
    this.markedAt,
    this.name,
  }) : super(
          id: id,
          uid: uid,
          markedAt: markedAt,
          name: name,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'markedAt': markedAt,
      'name': name,
    };
  }

  factory AttendanceModel.fromSnapshot(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'],
      uid: map['uid'],
      markedAt: map['markedAt']?.toDate(),
      name: map['name'],
    );
  }
}
