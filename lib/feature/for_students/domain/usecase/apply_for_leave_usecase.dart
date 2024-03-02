import '../entity/applcation_entity.dart';
import '../repo/student_repo.dart';

class ApplyForLeaveUseCase {
  final StudentRepo repo;

  ApplyForLeaveUseCase({required this.repo});
  Future<void> call(ApplicationEntity applicationEntity) =>
      repo.applyForLeave(applicationEntity: applicationEntity);
}
