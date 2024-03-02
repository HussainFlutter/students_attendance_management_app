import '../entity/user_entity.dart';
import '../repo/user_repo.dart';

class SignInWithEmailAndPasswordUseCase {
  final UserRepo repo;

  SignInWithEmailAndPasswordUseCase({required this.repo});
  Future<void> call({
    required String email,
    required String password,
    required UserEntity userEntity,
  }) =>
      repo.signInWithEmailAndPassword(
          email: email, password: password, userEntity: userEntity);
}
