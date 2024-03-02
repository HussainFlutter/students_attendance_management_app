import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'feature/auth/auth_injection_container.dart';

final sl = GetIt.instance;

Future<void> initialize() async {
  //Injections
  authInjection();
  //External dependencies
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
