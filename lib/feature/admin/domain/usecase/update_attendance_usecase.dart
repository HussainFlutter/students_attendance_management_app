import '../../../for_students/domain/entity/attendance_entity.dart';
import '../repo/admin_repo.dart';

class UpdateAttendanceUseCase {
  final AdminRepo repo;

  UpdateAttendanceUseCase({required this.repo});
  Future<void> call({required AttendanceEntity attendance}) =>
      repo.updateAttendance(attendance: attendance);
}
