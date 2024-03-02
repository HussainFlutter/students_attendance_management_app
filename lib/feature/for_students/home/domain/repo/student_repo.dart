import '../entity/applcation_entity.dart';
import '../entity/attendance_entity.dart';

abstract class StudentRepo {
  Future<void> markAttendance({required String name, required String uid});
  Stream<bool> attendanceStatus({required String uid});
  Future<void> applyForLeave({required ApplicationEntity applicationEntity});
  Stream<List<AttendanceEntity>?> getStudentAttendance({required String uid});
}
