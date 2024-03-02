import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/data/model/user_model.dart';
import 'package:students_attendance_management_app/feature/for_students/home/data/data_source/remote/student_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/for_students/home/data/model/application_model.dart';
import 'package:students_attendance_management_app/feature/for_students/home/data/model/attendance_model.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/entity/attendance_entity.dart';

import '../../../../../../main_injection_container.dart';

class StudentRepoRemoteDataSourceImpl extends StudentRepoRemoteDataSource {
  final application = FirebaseConsts.application;
  final myAttendance = FirebaseConsts.myAttendance;
  final attendance = FirebaseConsts.attendance;
  final user = FirebaseConsts.user;
  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<void> markAttendance(
      {required String name, required String uid}) async {
    try {
      await firestore.collection(user).doc(uid).update({
        "attendance": true,
        "lastAttendanceAt": DateTime.now(),
      }).then((value) {
        final id = randomId.v1();
        final AttendanceModel attendanceModel = AttendanceModel(
          name: name,
          uid: uid,
          markedAt: DateTime.now(),
          id: id,
        );
        // Adding attendance to the user's attendance collection
        firestore
            .collection(user)
            .doc(uid)
            .collection(myAttendance)
            .doc(id)
            .set(attendanceModel.toMap());
        //Adding attendance to the attendance collection
        firestore.collection(attendance).doc(id).set(attendanceModel.toMap());
      });
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<void> applyForLeave(
      {required ApplicationEntity applicationEntity}) async {
    try {
      final id = randomId.v1();
      final ApplicationModel applicationModel = ApplicationModel(
        applicationId: id,
        name: applicationEntity.name,
        createAt: DateTime.now(),
        paragraph: applicationEntity.paragraph,
        uid: applicationEntity.uid,
      );
      //Sending application to data base
      await firestore
          .collection(application)
          .doc(id)
          .set(applicationModel.toMap());
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Stream<bool> attendanceStatus({required String uid}) {
    try {
      return firestore.collection(user).doc(uid).snapshots().map((event) =>
          UserModel.fromSnapshot(event.data() as Map<String, dynamic>)
              .attendance!);
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Stream<List<AttendanceEntity>?> getStudentAttendance({required String uid}) {
    try {
      return firestore
          .collection(user)
          .doc(uid)
          .collection(myAttendance)
          .snapshots()
          .map((event) => event.docs.isEmpty
              ? null
              : event.docs
                  .map((e) => AttendanceModel.fromSnapshot(e.data()))
                  .toList());
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }
}
