import 'package:students_attendance_management_app/feature/for_students/home/domain/entity/attendance_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/repo/student_repo.dart';

class GetStudentAttendanceUseCase {
  final StudentRepo repo;

  GetStudentAttendanceUseCase({required this.repo});
  Stream<List<AttendanceEntity>?> call(String uid) =>
      repo.getStudentAttendance(uid: uid);
}
