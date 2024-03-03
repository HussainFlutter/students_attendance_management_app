import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source_impl.dart';
import 'package:students_attendance_management_app/feature/admin/data/repo/admin_repo_impl.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/delete_attendance_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_leave_applications_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_loggedin_students_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/get_all_student_attendances_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/domain/usecase/update_attendance_usecase.dart';
import 'package:students_attendance_management_app/feature/admin/presentation/bloc/admin_bloc.dart';

import '../../main_injection_container.dart';
import 'domain/repo/admin_repo.dart';

Future<void> adminInjection() async {
  //Blocs
  sl.registerFactory(() => AdminBloc(
        deleteAttendance: sl<DeleteAttendanceUseCase>(),
        updateAttendance: sl<UpdateAttendanceUseCase>(),
      ));
  //Use Cases
  sl.registerLazySingleton(
      () => GetAllLoggedInStudentsUseCase(repo: sl<AdminRepo>()));
  sl.registerLazySingleton(
      () => GetAllAttendancesUseCase(repo: sl<AdminRepo>()));
  sl.registerLazySingleton(
      () => GetAllLeaveApplicationsUseCase(repo: sl<AdminRepo>()));
  sl.registerLazySingleton(
      () => DeleteAttendanceUseCase(repo: sl<AdminRepo>()));
  sl.registerLazySingleton(
      () => UpdateAttendanceUseCase(repo: sl<AdminRepo>()));

  //Repositories
  sl.registerLazySingleton<AdminRepo>(
      () => AdminRepoImpl(dataSource: sl<AdminRepoRemoteDataSource>()));
  sl.registerLazySingleton<AdminRepoRemoteDataSource>(
      () => AdminRepoRemoteDataSourceImpl());
}
