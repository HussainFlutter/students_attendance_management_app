import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/admin/domain/repo/repo.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

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
}
