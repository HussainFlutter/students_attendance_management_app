import '../entity/attendance_entity.dart';
import '../repo/student_repo.dart';

class GetStudentAttendanceUseCase {
  final StudentRepo repo;

  GetStudentAttendanceUseCase({required this.repo});
  Stream<List<AttendanceEntity>?> call(String uid) =>
      repo.getStudentAttendance(uid: uid);
}
