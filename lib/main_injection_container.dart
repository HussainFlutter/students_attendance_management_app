import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:students_attendance_management_app/feature/admin/admin_injection.dart';
import 'package:students_attendance_management_app/feature/for_students/student_injection.dart';
import 'package:uuid/uuid.dart';

import 'feature/auth/auth_injection_container.dart';

final sl = GetIt.instance;
const randomId = Uuid();
Future<void> initialize() async {
  //Injections
  await authInjection();
  await studentInjection();
  await adminInjection();
  //External dependencies
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
}
