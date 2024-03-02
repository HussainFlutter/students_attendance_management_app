import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';

import '../../../domain/usecases/get_user_usecase.dart';
import '../../../domain/usecases/is_login_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final IsLoginUseCase isLogin;
  final GetUserUseCase getUser;
  SplashBloc({required this.isLogin, required this.getUser})
      : super(SplashInitial()) {
    on<IsLoginEvent>((event, emit) => _isLogin(event));
  }
  Future<void> _isLogin(
    IsLoginEvent event,
  ) async {
    try {
      bool login = await isLogin();
      if (login == true) {
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
      } else {
        if (event.context.mounted) {
          Navigator.pushNamed(event.context, RouteConsts.login);
        }
      }
    } on FirebaseAuthException catch (e) {
      toast(message: e.message!);
    } catch (e) {
      toast(message: e.toString());
      customPrint(message: e.toString());
      rethrow;
    }
  }
}
