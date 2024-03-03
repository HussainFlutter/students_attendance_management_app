import '../../../auth/domain/entity/user_entity.dart';
import '../repo/student_repo.dart';

class AttendanceStatusUseCase {
  final StudentRepo repo;

  AttendanceStatusUseCase({required this.repo});
  Stream<UserEntity> call(String uid) => repo.attendanceStatus(uid: uid);
}
