import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/data/datasource/remote/user_repo_data_source.dart';
import 'package:students_attendance_management_app/feature/auth/data/model/user_model.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

import '../../../../../main_injection_container.dart';

class UserRepoDataSourceImpl extends UserRepoDataSource {
  final firestore = sl<FirebaseFirestore>();
  final auth = sl<FirebaseAuth>();
  final String user = FirebaseConsts.user;

  @override
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required UserEntity userEntity,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        final user = UserEntity(name: userEntity.name, uid: value.user!.uid);
        await createUser(userEntity: user);
      });
    } catch (e) {
      customPrint(message: "signInWithEmailAndPassword $e");
      rethrow;
    }
  }

  @override
  Future<void> createUser({required UserEntity userEntity}) async {
    try {
      final model = UserModel(
        name: userEntity.name,
        uid: userEntity.uid,
        createAt: DateTime.now(),
        lastAttendanceAt: null,
        attendance: false,
        admin: false,
      );
      await firestore.collection(user).doc(model.uid).set(
            model.toMap(),
          );
    } catch (e) {
      customPrint(message: "createUser $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    try {
      await firestore.collection(user).doc(uid).delete();
    } catch (e) {
      customPrint(message: "deleteUser $e");
      rethrow;
    }
  }

  @override
  Stream<UserEntity> getUser() {
    try {
      String uid = auth.currentUser!.uid;
      return firestore.collection(user).doc(uid).snapshots().map((event) =>
          UserModel.fromSnapshot(event.data() as Map<String, dynamic>));
    } catch (e) {
      customPrint(message: "getUser $e");
      rethrow;
    }
  }

  @override
  Future<void> updateUser({required UserEntity userEntity}) async {
    try {
      Map<String, dynamic> data = {};
      if (userEntity.name != null && userEntity.name != "") {
        data["name"] = userEntity.name;
      }
      if (userEntity.lastAttendanceAt != null) {
        data["lastAttendanceAt"] = userEntity.lastAttendanceAt;
      }
      if (userEntity.createAt != null) {
        data["createAt"] = userEntity.createAt;
      }
      if (userEntity.attendance != null) {
        data["attendance"] = userEntity.attendance;
      }
      await firestore.collection(user).doc().update(data);
    } catch (e) {
      customPrint(message: "updateUser $e");
      rethrow;
    }
  }

  @override
  Future<bool> isLogin() async {
    try {
      if (auth.currentUser == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      customPrint(message: "isLogin $e");
      rethrow;
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      customPrint(message: "login $e");
      rethrow;
    }
  }
}
