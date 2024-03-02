import 'package:students_attendance_management_app/feature/for_students/home/domain/repo/student_repo.dart';

class MarkAttendanceUseCase {
  final StudentRepo repo;

  MarkAttendanceUseCase({required this.repo});
  Future<void> call({required String uid, required String name}) =>
      repo.markAttendance(name: name, uid: uid);
}
