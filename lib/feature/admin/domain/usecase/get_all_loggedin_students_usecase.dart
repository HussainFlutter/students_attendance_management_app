import '../../../auth/domain/entity/user_entity.dart';
import '../repo/admin_repo.dart';

class GetAllLoggedInStudentsUseCase {
  final AdminRepo repo;

  GetAllLoggedInStudentsUseCase({required this.repo});
  Stream<List<UserEntity>?> call() => repo.getAllLoggedInStudents();
}
