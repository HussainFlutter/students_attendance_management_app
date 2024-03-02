import 'package:students_attendance_management_app/feature/for_students/home/domain/entity/applcation_entity.dart';
import 'package:students_attendance_management_app/feature/for_students/home/domain/repo/student_repo.dart';

class ApplyForLeaveUseCase {
  final StudentRepo repo;

  ApplyForLeaveUseCase({required this.repo});
  Future<void> call(ApplicationEntity applicationEntity) =>
      repo.applyForLeave(applicationEntity: applicationEntity);
}
