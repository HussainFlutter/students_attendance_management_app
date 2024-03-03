import 'package:students_attendance_management_app/feature/admin/domain/repo/repo.dart';

import '../../../auth/domain/entity/user_entity.dart';

class GetAllLoggedInStudentsUseCase {
  final AdminRepo repo;

  GetAllLoggedInStudentsUseCase({required this.repo});
  Stream<List<UserEntity>?> call() => repo.getAllLoggedInStudents();
}
