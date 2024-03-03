import 'package:students_attendance_management_app/feature/admin/domain/repo/repo.dart';

import '../../../for_students/domain/entity/applcation_entity.dart';

class GetAllLeaveApplicationsUseCase {
  final AdminRepo repo;

  GetAllLeaveApplicationsUseCase({required this.repo});
  Stream<List<ApplicationEntity>?> call() => repo.getAllLeaveApplications();
}
