import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source_impl.dart';
import 'package:students_attendance_management_app/feature/admin/data/repo/admin_repo_impl.dart';
import 'package:students_attendance_management_app/feature/admin/domain/repo/repo.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_leave_applications_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_loggedin_students_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_student_attendances_usecase.dart';

import '../../main_injection_container.dart';

Future<void> adminInjection() async {
  //Use Cases
  sl.registerLazySingleton(
      () => GetAllLoggedInStudentsUseCase(repo: sl<AdminRepo>()));
  sl.registerLazySingleton(
      () => GetAllAttendancesUseCase(repo: sl<AdminRepo>()));
  sl.registerLazySingleton(
      () => GetAllLeaveApplicationsUseCase(repo: sl<AdminRepo>()));
  //Repositories
  sl.registerLazySingleton<AdminRepo>(
      () => AdminRepoImpl(dataSource: sl<AdminRepoRemoteDataSource>()));
  sl.registerLazySingleton<AdminRepoRemoteDataSource>(
      () => AdminRepoRemoteDataSourceImpl());
}
