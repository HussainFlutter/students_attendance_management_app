import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/add_to_attended_days.dart';
import 'package:students_attendance_management_app/feature/for_students/data/data_source/remote/student_remote_data_source.dart';

import '../../../../../core/constants.dart';
import '../../../../../main_injection_container.dart';
import '../../../../auth/data/model/user_model.dart';
import '../../../domain/entity/applcation_entity.dart';
import '../../../domain/entity/attendance_entity.dart';
import '../../model/application_model.dart';
import '../../model/attendance_model.dart';

class StudentRepoRemoteDataSourceImpl extends StudentRepoRemoteDataSource {
  final application = FirebaseConsts.application;
  final myAttendance = FirebaseConsts.myAttendance;
  final attendanceCollection = FirebaseConsts.attendance;
  final user = FirebaseConsts.user;
  final FirebaseFirestore firestore = sl<FirebaseFirestore>();

  @override
  Future<void> markAttendance({
    required String name,
    required String email,
    required String uid,
    required bool attendance,
  }) async {
    try {
      //Updating the student information
      await firestore.collection(user).doc(uid).update({
        "attendance": attendance,
        "lastAttendanceAt": DateTime.now(),
      }).then((value) async {
        final id = randomId.v1();
        final AttendanceModel attendanceModel = AttendanceModel(
          name: name,
          uid: uid,
          markedAt: attendance == true
              ? DateTime.now()
              : DateTime.now().subtract(const Duration(days: 1)),
          id: id,
          attendance: attendance,
          email: email,
        );
        // Adding attendance to the user's attendance collection
        await firestore
            .collection(user)
            .doc(uid)
            .collection(myAttendance)
            .doc(id)
            .set(attendanceModel.toMap());
        await sl<AddToAttendedDays>().call(uid, false);
        //Adding attendance to the attendance collection
        await firestore
            .collection(attendanceCollection)
            .doc(id)
            .set(attendanceModel.toMap());
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
        email: applicationEntity.email,
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
  Stream<UserEntity> attendanceStatus({required String uid}) {
    try {
      return firestore.collection(user).doc(uid).snapshots().map((event) =>
          UserModel.fromSnapshot(event.data() as Map<String, dynamic>));
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
