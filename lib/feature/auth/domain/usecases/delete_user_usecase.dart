import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class DeleteUserUseCase {
  final UserRepo repo;

  DeleteUserUseCase({required this.repo});
  Future<void> call(String uid) => repo.deleteUser(uid: uid);
}
