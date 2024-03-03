import '../../domain/entity/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity {
  final String? id;
  final String? uid;
  final String? email;
  final DateTime? markedAt;
  final String? name;
  final bool? attendance;

  const AttendanceModel({
    this.id,
    this.uid,
    this.email,
    this.markedAt,
    this.name,
    this.attendance,
  }) : super(
          id: id,
          uid: uid,
          markedAt: markedAt,
          name: name,
          attendance: attendance,
          email: email,
        );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'markedAt': markedAt,
      'name': name,
      'attendance': attendance,
      'email': email,
    };
  }

  factory AttendanceModel.fromSnapshot(Map<String, dynamic> map) {
    return AttendanceModel(
      id: map['id'],
      uid: map['uid'],
      email: map['email'],
      markedAt: map['markedAt']?.toDate(),
      name: map['name'],
      attendance: map['attendance'],
    );
  }
}
