import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

import '../../domain/repo/admin_repo.dart';

class AdminRepoImpl extends AdminRepo {
  final AdminRepoRemoteDataSource dataSource;

  AdminRepoImpl({required this.dataSource});

  @override
  Stream<List<AttendanceEntity>?> getAllAttendances() =>
      dataSource.getAllAttendances();

  @override
  Stream<List<ApplicationEntity>?> getAllLeaveApplications() =>
      dataSource.getAllLeaveApplications();

  @override
  Stream<List<UserEntity>?> getAllLoggedInStudents() =>
      dataSource.getAllLoggedInStudents();

  @override
  Future<void> deleteAttendance({required String id, required String uid}) =>
      dataSource.deleteAttendance(uid: uid, id: id);

  @override
  Future<void> updateAttendance({required AttendanceEntity attendance}) =>
      dataSource.updateAttendance(attendance: attendance);
}
