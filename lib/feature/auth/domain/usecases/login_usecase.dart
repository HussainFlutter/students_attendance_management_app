import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class LoginUseCase {
  final UserRepo repo;
  LoginUseCase({required this.repo});
  Future<void> call({required String email, required String password}) =>
      repo.login(email: email, password: password);
}
