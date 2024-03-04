import 'package:students_attendance_management_app/feature/for_students/domain/usecase/change_grade_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/usecase/mark_grade_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/presentation/bloc/home_bloc.dart';

import '../../main_injection_container.dart';
import 'data/data_source/remote/student_remote_data_source.dart';
import 'data/data_source/remote/student_remote_data_source_impl.dart';
import 'data/repo/student_repo_impl.dart';
import 'domain/repo/student_repo.dart';
import 'domain/usecase/apply_for_leave_usecase.dart';
import 'domain/usecase/attendance_status_usecase.dart';
import 'domain/usecase/get_student_attendance_usecase.dart';
import 'domain/usecase/mark_attendance_usecase.dart';

Future<void> studentInjection() async {
  //Blocs
  sl.registerFactory(() => HomeBloc(
        applyForLeave: sl<ApplyForLeaveUseCase>(),
        attendanceStatus: sl<AttendanceStatusUseCase>(),
        getStudentAttendance: sl<GetStudentAttendanceUseCase>(),
        markAttendance: sl<MarkAttendanceUseCase>(),
        markGrade: sl<MarkGradeUseCase>(),
      ));
  //Use cases
  sl.registerLazySingleton(() => ApplyForLeaveUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(
      () => AttendanceStatusUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(
      () => GetStudentAttendanceUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(
      () => MarkAttendanceUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(() => MarkGradeUseCase(repo: sl<StudentRepo>()));
  sl.registerLazySingleton(() => ChangeGradeUseCase(repo: sl<StudentRepo>()));
  //Repositories
  sl.registerLazySingleton<StudentRepo>(
      () => StudentRepoImpl(dataSource: sl<StudentRepoRemoteDataSource>()));
  sl.registerLazySingleton<StudentRepoRemoteDataSource>(
      () => StudentRepoRemoteDataSourceImpl());
}
