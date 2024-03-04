import '../../../auth/domain/entity/user_entity.dart';
import '../entity/applcation_entity.dart';
import '../entity/attendance_entity.dart';

abstract class StudentRepo {
  Future<void> markAttendance({
    required String name,
    required String uid,
    required String email,
    required bool attendance,
  });
  Stream<UserEntity> attendanceStatus({required String uid});
  Future<void> applyForLeave({required ApplicationEntity applicationEntity});
  Stream<List<AttendanceEntity>?> getStudentAttendance({required String uid});
  Future<void> markGrade({required String uid});
  Future<void> changeGrade({required String uid, required Grades grade});
}
