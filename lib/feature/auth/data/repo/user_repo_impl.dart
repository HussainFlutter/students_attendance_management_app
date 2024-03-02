import 'package:students_attendance_management_app/feature/auth/data/datasource/remote/user_repo_data_source.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserRepoDataSource repo;
  UserRepoImpl({required this.repo});

  @override
  Future<void> createUser({required UserEntity userEntity}) =>
      repo.createUser(userEntity: userEntity);

  @override
  Future<void> deleteUser({required String uid}) => repo.deleteUser(uid: uid);

  @override
  Stream<UserEntity> getUser() => repo.getUser();

  @override
  Future<void> updateUser({required UserEntity userEntity}) =>
      repo.updateUser(userEntity: userEntity);

  @override
  Future<bool> isLogin() => repo.isLogin();

  @override
  Future<void> signInWithEmailAndPassword(
          {required String email,
          required String password,
          required UserEntity userEntity}) =>
      repo.signInWithEmailAndPassword(
          email: email, password: password, userEntity: userEntity);
}
