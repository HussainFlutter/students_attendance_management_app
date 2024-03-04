import 'package:students_attendance_management_app/feature/for_students/domain/repo/student_repo.dart';

import '../../../auth/domain/entity/user_entity.dart';

class ChangeGradeUseCase {
  final StudentRepo repo;

  ChangeGradeUseCase({required this.repo});
  Future<void> call({required String uid, required Grades grade}) =>
      repo.changeGrade(uid: uid, grade: grade);
}
