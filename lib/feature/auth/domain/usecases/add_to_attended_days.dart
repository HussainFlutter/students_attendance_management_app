import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class AddToAttendedDays {
  final UserRepo repo;

  AddToAttendedDays({required this.repo});
  Future<void> call(
    String uid,
    bool minus,
  ) =>
      repo.addToAttendedDays(uid: uid, minus: minus);
}
