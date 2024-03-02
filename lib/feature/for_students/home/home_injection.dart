import 'package:students_attendance_management_app/feature/for_students/home/data/data_source/remote/student_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/for_students/home/data/data_source/remote/student_remote_data_source_impl.dart';
import 'package:students_attendance_management_app/feature/for_students/home/data/repo/student_repo_impl.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/repo/student_repo.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/usecase/apply_for_leave_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/usecase/attendance_status_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/usecase/get_student_attendance_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/usecase/mark_attendance_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/home/presentation/bloc/home_bloc.dart';

import '../../../main_injection_container.dart';

Future<void> homeInjection() async {
  //Blocs
  sl.registerFactory(() => HomeBloc(
        applyForLeave: sl<ApplyForLeaveUseCase>(),
        attendanceStatus: sl<AttendanceStatusUseCase>(),
        getStudentAttendance: sl<GetStudentAttendanceUseCase>(),
        markAttendance: sl<MarkAttendanceUseCase>(),
      ));
  //Use cases
  sl.registerLazySingleton(() => ApplyForLeaveUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(
      () => AttendanceStatusUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(
      () => GetStudentAttendanceUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(
      () => MarkAttendanceUseCase(repo: sl<StudentRepo>()));
  //Repositories
  sl.registerLazySingleton<StudentRepo>(
      () => StudentRepoImpl(dataSource: sl<StudentRepoRemoteDataSource>()));
  sl.registerLazySingleton<StudentRepoRemoteDataSource>(
      () => StudentRepoRemoteDataSourceImpl());
}
