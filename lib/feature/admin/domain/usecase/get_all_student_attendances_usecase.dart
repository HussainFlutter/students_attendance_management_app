import 'package:students_attendance_management_app/feature/admin/domain/repo/repo.dart';

import '../../../for_students/domain/entity/attendance_entity.dart';

class GetAllAttendancesUseCase {
  final AdminRepo repo;

  GetAllAttendancesUseCase({required this.repo});
  Stream<List<AttendanceEntity>?> call() => repo.getAllAttendances();
}
