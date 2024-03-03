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
  final user = FirebaseConsts.user;

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
          .collection(user)
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
}
