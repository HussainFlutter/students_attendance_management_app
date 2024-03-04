import 'package:students_attendance_management_app/feature/admin/domain/repo/admin_repo.dart';

import '../../../for_students/domain/entity/attendance_entity.dart';

class FromToDateOfAllStudentAttendanceUseCase {
  final AdminRepo repo;

  FromToDateOfAllStudentAttendanceUseCase({required this.repo});
  Future<List<AttendanceEntity>> call({
    required DateTime fromDate,
    required DateTime toDate,
  }) =>
      repo.fromToDateOfAllStudentAttendance(fromDate: fromDate, toDate: toDate);
}
