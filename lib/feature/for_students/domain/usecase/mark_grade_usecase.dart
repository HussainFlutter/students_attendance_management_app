import '../repo/student_repo.dart';

class MarkGradeUseCase {
  final StudentRepo repo;

  MarkGradeUseCase({required this.repo});
  Future<void> call({required String uid}) => repo.markGrade(uid: uid);
}
