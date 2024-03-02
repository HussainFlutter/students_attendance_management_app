import '../repo/user_repo.dart';

class IsLoginUseCase {
  final UserRepo repo;

  IsLoginUseCase({required this.repo});
  Future<bool> call() => repo.isLogin();
}
