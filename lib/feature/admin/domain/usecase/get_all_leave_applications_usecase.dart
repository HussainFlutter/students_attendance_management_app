import '../../../for_students/domain/entity/applcation_entity.dart';
import '../repo/admin_repo.dart';

class GetAllLeaveApplicationsUseCase {
  final AdminRepo repo;

  GetAllLeaveApplicationsUseCase({required this.repo});
  Stream<List<ApplicationEntity>?> call() => repo.getAllLeaveApplications();
}
