import 'package:students_attendance_management_app/feature/for_students/home/domain/repo/student_repo.dart';

class AttendanceStatusUseCase {
  final StudentRepo repo;

  AttendanceStatusUseCase({required this.repo});
  Stream<bool> call(String uid) => repo.attendanceStatus(uid: uid);
}
