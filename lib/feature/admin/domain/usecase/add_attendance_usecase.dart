import 'package:students_attendance_management_app/feature/admin/domain/repo/admin_repo.dart';

class AddAttendanceUseCase {
  final AdminRepo repo;

  AddAttendanceUseCase({required this.repo});

  Future<void> call({required String email, required bool attendance}) =>
      repo.addAttendance(email: email, attendance: attendance);
}
