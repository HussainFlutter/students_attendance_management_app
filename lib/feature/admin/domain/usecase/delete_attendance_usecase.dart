import 'package:students_attendance_management_app/feature/admin/domain/repo/admin_repo.dart';

class DeleteAttendanceUseCase {
  final AdminRepo repo;

  DeleteAttendanceUseCase({required this.repo});
  Future<void> call({required String id, required String uid}) =>
      repo.deleteAttendance(id: id, uid: uid);
}
