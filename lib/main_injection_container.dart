import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:students_attendance_management_app/feature/for_students/home/home_injection.dart';
import 'package:uuid/uuid.dart';

import 'feature/auth/auth_injection_container.dart';

final sl = GetIt.instance;
const randomId = Uuid();
Future<void> initialize() async {
  //External dependencies
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  //Injections
  await authInjection();
  await homeInjection();
}
