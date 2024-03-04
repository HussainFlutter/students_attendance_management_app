import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

abstract class UserRepoDataSource {
  Future<void> createUser({required UserEntity userEntity});
  Future<void> deleteUser({required String uid});
  Future<void> updateUser({required UserEntity userEntity});
  Stream<UserEntity> getUser();
  Future<bool> isLogin();
  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required UserEntity userEntity,
  });
  Future<void> login({required String email, required String password});
  Future<void> uploadProfilePic({
    required String profilePic,
    required String uid,
  });
  Future<void> addToAttendedDays({
    required String uid,
    required bool minus,
  });
}
