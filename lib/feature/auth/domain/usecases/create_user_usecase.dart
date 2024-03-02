import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class CreateUserUseCase {
  final UserRepo repo;

  CreateUserUseCase({required this.repo});
  Future<void> call(UserEntity userEntity) =>
      repo.createUser(userEntity: userEntity);
}
