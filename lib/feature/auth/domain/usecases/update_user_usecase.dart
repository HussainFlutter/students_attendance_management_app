import '../entity/user_entity.dart';
import '../repo/user_repo.dart';

class UpdateUserUseCase {
  final UserRepo repo;

  UpdateUserUseCase({required this.repo});
  Future<void> call(UserEntity userEntity) =>
      repo.updateUser(userEntity: userEntity);
}
