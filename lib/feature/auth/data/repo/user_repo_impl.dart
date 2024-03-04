import 'package:students_attendance_management_app/feature/auth/data/datasource/remote/user_repo_data_source.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class UserRepoImpl extends UserRepo {
  final UserRepoDataSource dataSource;
  UserRepoImpl({required this.dataSource});

  @override
  Future<void> createUser({required UserEntity userEntity}) =>
      dataSource.createUser(userEntity: userEntity);

  @override
  Future<void> deleteUser({required String uid}) =>
      dataSource.deleteUser(uid: uid);

  @override
  Stream<UserEntity> getUser() => dataSource.getUser();

  @override
  Future<void> updateUser({required UserEntity userEntity}) =>
      dataSource.updateUser(userEntity: userEntity);

  @override
  Future<bool> isLogin() => dataSource.isLogin();

  @override
  Future<void> signInWithEmailAndPassword(
          {required String email,
          required String password,
          required UserEntity userEntity}) =>
      dataSource.signUpWithEmailAndPassword(
          email: email, password: password, userEntity: userEntity);

  @override
  Future<void> login({required String email, required String password}) =>
      dataSource.login(email: email, password: password);

  @override
  Future<void> uploadProfilePic(
          {required String profilePic, required String uid}) =>
      dataSource.uploadProfilePic(profilePic: profilePic, uid: uid);

  @override
  Future<void> addToAttendedDays({required String uid}) =>
      dataSource.addToAttendedDays(uid: uid);
}
