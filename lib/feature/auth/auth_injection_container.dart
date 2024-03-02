import 'package:students_attendance_management_app/feature/auth/data/datasource/remote/user_repo_data_source_impl.dart';
import 'package:students_attendance_management_app/feature/auth/data/repo/user_repo_impl.dart';
import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/create_user_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/delete_user_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/get_user_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/is_login_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/sign_in_with_email_and_password_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/update_user_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/presentation/bloc/splash_bloc/splash_bloc.dart';

import '../../main_injection_container.dart';
import 'data/datasource/remote/user_repo_data_source.dart';

Future<void> authInjection() async {
  // Blocs
  sl.registerFactory(() =>
      SplashBloc(isLogin: sl<IsLoginUseCase>(), getUser: sl<GetUserUseCase>()));
  //Use Cases
  sl.registerLazySingleton(() => CreateUserUseCase(repo: sl<UserRepo>()));
  sl.registerLazySingleton(() => DeleteUserUseCase(repo: sl<UserRepo>()));
  sl.registerLazySingleton(() => UpdateUserUseCase(repo: sl<UserRepo>()));
  sl.registerLazySingleton(() => GetUserUseCase(repo: sl<UserRepo>()));
  sl.registerLazySingleton(() => IsLoginUseCase(repo: sl<UserRepo>()));
  sl.registerLazySingleton(
      () => SignInWithEmailAndPasswordUseCase(repo: sl<UserRepo>()));
  // Repositories
  sl.registerLazySingleton<UserRepo>(
      () => UserRepoImpl(repo: sl<UserRepoDataSource>()));
  sl.registerLazySingleton<UserRepoDataSource>(() => UserRepoDataSourceImpl());
}
