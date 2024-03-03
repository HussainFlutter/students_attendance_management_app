import '../repo/student_repo.dart';

class MarkAttendanceUseCase {
  final StudentRepo repo;

  MarkAttendanceUseCase({required this.repo});
  Future<void> call({
    required bool attendance,
    required String uid,
    required String email,
    required String name,
  }) =>
      repo.markAttendance(
          email: email, name: name, uid: uid, attendance: attendance);
}
