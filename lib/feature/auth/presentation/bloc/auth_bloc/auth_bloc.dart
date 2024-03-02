import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/login_usecase.dart';

import '../../../domain/usecases/get_user_usecase.dart';
import '../../../domain/usecases/sign_in_with_email_and_password_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPasswordUseCase signUp;
  final LoginUseCase login;
  final GetUserUseCase getUser;
  AuthBloc({required this.getUser, required this.signUp, required this.login})
      : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) => _signUp(event));
    on<LoginEvent>((event, emit) => _login(event));
  }
  Future<void> _signUp(SignUpEvent event) async {
    try {
      //Creating the user in Firestore and registering them in Firebase Auth
      await signUp(
              email: event.email,
              password: event.password,
              userEntity: UserEntity(name: event.name))
          .then((value) {
        toast(
          message: "Account created",
          backGroundColor: Colors.green,
        );
        Navigator.pushReplacementNamed(event.context, RouteConsts.login);
      });
    } on FirebaseAuthException catch (e) {
      toast(message: e.message.toString());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  Future<void> _login(LoginEvent event) async {
    try {
      await login(email: event.email, password: event.password);
      if (event.context.mounted) {
        UserEntity user = const UserEntity();
        getUser().listen((event) {
          user = event;
        }).onDone(() {
          if (event.context.mounted) {
            Navigator.popUntil(event.context, (route) => route.isFirst);
            Navigator.pushNamed(
              event.context,
              RouteConsts.home,
              arguments: user,
            );
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      toast(message: e.message.toString());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }
}
