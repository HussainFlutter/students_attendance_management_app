import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

abstract class UserRepo {
  Future<void> createUser({required UserEntity userEntity});
  Future<void> deleteUser({required String uid});
  Future<void> updateUser({required UserEntity userEntity});
  Stream<UserEntity> getUser();
  Future<bool> isLogin();
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required UserEntity userEntity,
  });
  Future<void> login({required String email, required String password});
}
