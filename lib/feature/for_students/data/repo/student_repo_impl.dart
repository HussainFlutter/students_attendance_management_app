import '../../../auth/domain/entity/user_entity.dart';
import '../../domain/entity/applcation_entity.dart';
import '../../domain/entity/attendance_entity.dart';
import '../../domain/repo/student_repo.dart';
import '../data_source/remote/student_remote_data_source.dart';

class StudentRepoImpl extends StudentRepo {
  final StudentRepoRemoteDataSource dataSource;

  StudentRepoImpl({required this.dataSource});
  @override
  Future<void> applyForLeave({required ApplicationEntity applicationEntity}) =>
      dataSource.applyForLeave(applicationEntity: applicationEntity);

  @override
  Stream<UserEntity> attendanceStatus({required String uid}) =>
      dataSource.attendanceStatus(uid: uid);

  @override
  Stream<List<AttendanceEntity>?> getStudentAttendance({required String uid}) =>
      dataSource.getStudentAttendance(uid: uid);

  @override
  Future<void> markAttendance({
    required bool attendance,
    required String name,
    required String email,
    required String uid,
  }) =>
      dataSource.markAttendance(
          name: name, uid: uid, attendance: attendance, email: email);
}
