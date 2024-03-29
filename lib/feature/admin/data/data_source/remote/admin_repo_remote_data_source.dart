import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

abstract class AdminRepoRemoteDataSource {
  Stream<List<ApplicationEntity>?> getAllLeaveApplications();
  Stream<List<UserEntity>?> getAllLoggedInStudents();
  Stream<List<AttendanceEntity>?> getAllAttendances();
  Future<void> deleteAttendance({required String id, required String uid});
  Future<void> updateAttendance({required AttendanceEntity attendance});
  Future<void> addAttendance({required String email, required bool attendance});
  Future<List<AttendanceEntity>> fromToDateStudentAttendance({
    required DateTime fromDate,
    required DateTime toDate,
    required String email,
  });
  Future<List<AttendanceEntity>> fromToDateOfAllStudentAttendance({
    required DateTime fromDate,
    required DateTime toDate,
  });
}
