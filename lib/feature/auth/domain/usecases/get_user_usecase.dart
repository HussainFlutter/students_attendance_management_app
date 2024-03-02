import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class GetUserUseCase {
  final UserRepo repo;

  GetUserUseCase({required this.repo});
  Stream<UserEntity> call() => repo.getUser();
}
