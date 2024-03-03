import '../../../for_students/domain/entity/attendance_entity.dart';
import '../repo/admin_repo.dart';

class GetAllAttendancesUseCase {
  final AdminRepo repo;

  GetAllAttendancesUseCase({required this.repo});
  Stream<List<AttendanceEntity>?> call() => repo.getAllAttendances();
}
