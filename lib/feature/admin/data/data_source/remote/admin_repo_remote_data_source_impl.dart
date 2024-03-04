import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:students_attendance_management_app/feature/admin/data/data_source/remote/admin_repo_remote_data_source.dart';
import 'package:students_attendance_management_app/feature/auth/data/model/user_model.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/add_to_attended_days.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/update_user_usecase.dart';
import 'package:students_attendance_management_app/feature/for_students/data/model/application_model.dart';
import 'package:students_attendance_management_app/feature/for_students/data/model/attendance_model.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/entity/attendance_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/domain/usecase/mark_attendance_usecase.dart';

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
      //Getting lastAttendanceAt and markedAt
      final student = await firestore.collection(userCollection).doc(uid).get();
      final myAttendanceMarkAt = await firestore
          .collection(userCollection)
          .doc(uid)
          .collection(myAttendanceCollection)
          .doc(id)
          .get();

      final lastAttendance =
          await student.get("lastAttendanceAt").toDate() as DateTime;
      final markedAt =
          await myAttendanceMarkAt.get("markedAt").toDate() as DateTime;
      // If Last Attendance and marked at match as today
      // We update attendance to false
      if (lastAttendance.day == markedAt.day &&
          lastAttendance.month == markedAt.month &&
          lastAttendance.year == markedAt.year) {
        await sl<UpdateUserUseCase>()
            .call(UserEntity(uid: uid, attendance: false));
      }
      // Deleting from attendance collection
      await firestore.collection(attendanceCollection).doc(id).delete();
      // Deleting from user myAttendance collection
      await sl<AddToAttendedDays>().call(uid, true);
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

  @override
  Future<void> addAttendance(
      {required String email, required bool attendance}) async {
    try {
      // Getting the user using email
      final result = await firestore
          .collection(userCollection)
          .limit(1)
          .where("email", isEqualTo: email)
          .where("admin", isEqualTo: false)
          .get();
      if (result.docs.first.exists) {
        // Add attendance
        final fetchedUser = UserModel.fromSnapshot(result.docs.first.data());
        if (fetchedUser.attendance == false) {
          // Mark attendance if user has not already
          await sl<MarkAttendanceUseCase>().call(
            attendance: attendance,
            uid: fetchedUser.uid!,
            email: email,
            name: fetchedUser.name!,
          );
        } else {
          throw "User already attended class";
        }
      } else {
        throw "User with this email does not exist";
      }
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<List<AttendanceEntity>> fromToDateStudentAttendance({
    required DateTime fromDate,
    required DateTime toDate,
    required String email,
  }) async {
    try {
      //Fetch user from the email
      final result = await firestore
          .collection(userCollection)
          .limit(1)
          .where("admin", isEqualTo: false)
          .where("email", isEqualTo: email)
          .get();
      if (result.docs.first.exists) {
        //Fetch the user
        final student = UserModel.fromSnapshot(result.docs.first.data());
        final attendanceResult = await firestore
            .collection(userCollection)
            .doc(student.uid)
            .collection(myAttendanceCollection)
            .where("markedAt", isLessThanOrEqualTo: toDate)
            .where("markedAt", isGreaterThanOrEqualTo: fromDate)
            .get();
        // if attendanceResult is not empty then we return it
        if (attendanceResult.docs.isNotEmpty) {
          return attendanceResult.docs
              .map((e) => AttendanceModel.fromSnapshot(e.data()))
              .toList();
        } else {
          toast(message: "No Attendances found");
          throw "No Attendances found";
        }
      } else {
        toast(message: "No Student found with this email");
        throw "No Student found with this email";
      }
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  @override
  Future<List<AttendanceEntity>> fromToDateOfAllStudentAttendance({
    required DateTime fromDate,
    required DateTime toDate,
  }) async {
    try {
      final result = await firestore
          .collection(attendanceCollection)
          .where("markedAt", isLessThanOrEqualTo: toDate)
          .where("markedAt", isGreaterThanOrEqualTo: fromDate)
          .get();
      if (result.docs.isEmpty) {
        toast(message: "No Attendances found");
        throw "No Attendances found";
      } else {
        return result.docs
            .map((e) => AttendanceModel.fromSnapshot(e.data()))
            .toList();
      }
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }
}
