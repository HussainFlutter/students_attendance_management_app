import '../../../../auth/domain/entity/user_entity.dart';
import '../../../domain/entity/applcation_entity.dart';
import '../../../domain/entity/attendance_entity.dart';

abstract class StudentRepoRemoteDataSource {
  Future<void> markAttendance({
    required String name,
    required String uid,
    required bool attendance,
    required String email,
  });
  Stream<UserEntity> attendanceStatus({required String uid});
  Future<void> applyForLeave({required ApplicationEntity applicationEntity});
  Stream<List<AttendanceEntity>?> getStudentAttendance({required String uid});
}
