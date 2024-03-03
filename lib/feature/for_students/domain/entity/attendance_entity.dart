import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String? id;
  final String? uid;
  final String? email;
  final DateTime? markedAt;
  final String? name;
  final bool? attendance;

  const AttendanceEntity({
    this.id,
    this.uid,
    this.markedAt,
    this.name,
    this.email,
    this.attendance,
  });
  @override
  List<Object?> get props => [
        id,
        uid,
        markedAt,
        name,
        attendance,
        email,
      ];
}
