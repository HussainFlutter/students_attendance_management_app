import 'package:students_attendance_management_app/feature/auth/domain/repo/user_repo.dart';

class UploadProfilePicUseCase {
  final UserRepo repo;

  UploadProfilePicUseCase({required this.repo});
  Future<void> call({required String uid, required String profilePic}) =>
      repo.uploadProfilePic(profilePic: profilePic, uid: uid);
}
