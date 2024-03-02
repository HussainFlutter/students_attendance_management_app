import '../repo/student_repo.dart';

class MarkAttendanceUseCase {
  final StudentRepo repo;

  MarkAttendanceUseCase({required this.repo});
  Future<void> call({required String uid, required String name}) =>
      repo.markAttendance(name: name, uid: uid);
}
