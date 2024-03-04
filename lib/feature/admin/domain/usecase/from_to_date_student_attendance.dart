import 'package:students_attendance_management_app/feature/admin/domain/repo/admin_repo.dart';

import '../../../for_students/domain/entity/attendance_entity.dart';

class FromToDateStudentAttendanceUseCase {
  final AdminRepo repo;

  FromToDateStudentAttendanceUseCase({required this.repo});

  Future<List<AttendanceEntity>> call({
    required DateTime fromDate,
    required DateTime toDate,
    required String email,
  }) =>
      repo.fromToDateStudentAttendance(
        fromDate: fromDate,
        toDate: toDate,
        email: email,
      );
}
