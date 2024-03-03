import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/auth/data/model/user_model.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/data/model/application_model.dart';
import 'package:students_attendance_management_app/feature/for_students/data/model/attendance_model.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';

import '../../../../../core/constants.dart';
import '../../../../../main_injection_container.dart';

class AdminRepoRemoteDataSourceImpl extends AdminRepoRemoteDataSource {
  final firestore = sl<FirebaseFirestore>();
  final application = FirebaseConsts.application;
  final attendanceCollection = FirebaseConsts.attendance;
  final myAttendanceCollection = FirebaseConsts.myAttendance;
  final userCollection = FirebaseConsts.user;

  @override
  Stream<List<AttendanceEntity>?> getAllAttendances() {
    try {
      return firestore.collection(attendanceCollection).snapshots().map(
          (event) => event.docs.isEmpty
              ? null
              : event.docs
                  .map((e) => AttendanceModel.fromSnapshot(e.data()))
                  .toList());
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<ApplicationEntity>?> getAllLeaveApplications() {
    try {
      return firestore.collection(application).snapshots().map((event) =>
          event.docs.isEmpty
              ? null
              : event.docs
                  .map((e) => ApplicationModel.fromSnapshot(e.data()))
                  .toList());
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<UserEntity>?> getAllLoggedInStudents() {
    try {
      return firestore
          .collection(userCollection)
          .where("admin", isEqualTo: false)
          .snapshots()
          .map((event) => event.docs.isEmpty
              ? null
              : event.docs
                  .map((e) => UserModel.fromSnapshot(e.data()))
                  .toList());
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteAttendance({
    required String id,
    required String uid,
  }) async {
    try {
      // Deleting from attendance collection
      await firestore.collection(attendanceCollection).doc(id).delete();
      // Deleting from user myAttendance collection
      await firestore
          .collection(userCollection)
          .doc(uid)
          .collection(myAttendanceCollection)
          .doc(id)
          .delete();
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> updateAttendance({required AttendanceEntity attendance}) async {
    try {
      if (attendance.attendance != null) {
        // Updating from attendance collection
        await firestore
            .collection(attendanceCollection)
            .doc(attendance.id)
            .update({
          "attendance": attendance.attendance,
        });
        // Updating from user myAttendance collection
        customPrint(message: attendance.toString());
        await firestore
            .collection(userCollection)
            .doc(attendance.uid)
            .collection(myAttendanceCollection)
            .doc(attendance.id)
            .update({
          "attendance": attendance.attendance,
        });
      }
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }
}
