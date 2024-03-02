import 'package:equatable/equatable.dart';

class AttendanceEntity extends Equatable {
  final String? id;
  final String? uid;
  final DateTime? markedAt;
  final String? name;

  const AttendanceEntity({
    this.id,
    this.uid,
    this.markedAt,
    this.name,
  });
  @override
  List<Object?> get props => [
        id,
        uid,
        markedAt,
        name,
      ];
}
