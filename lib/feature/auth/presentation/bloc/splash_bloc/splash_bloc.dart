import 'dart:async';

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
    IsLoginEvent event2,
  ) async {
    try {
      // Checking if user is logged in
      bool login = await isLogin();
      final Completer<void> completer = Completer();
      final StreamSubscription get;
      if (login == true) {
        UserEntity user = const UserEntity();
        // if user is logged in we get the his/her data and navigate them to the home screen
        get = getUser.call().listen((event) {
          user = event;
          completer.complete();
        })
          ..onDone(() {
            completer.complete();
          })
          ..onError((e) => completer.complete());
        await completer.future;
        get.cancel();
        //Checking if the user is null or not
        // if null we navigate them to login screen else to home screen
        if (user.uid != null) {
          //Waiting just to show splash screen we can remove this at anytime
          await Future.delayed(const Duration(seconds: 2));
          if (user.admin == true) {
            // Navigate to admin panel
            if (event2.context.mounted) {
              Navigator.popUntil(event2.context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(
                event2.context,
                RouteConsts.adminScreen,
                arguments: user,
              );
            }
          } else if (user.admin == false) {
            if (event2.context.mounted) {
              Navigator.popUntil(event2.context, (route) => route.isFirst);
              Navigator.pushReplacementNamed(
                event2.context,
                RouteConsts.home,
                arguments: user,
              );
            }
          } else {
            //Waiting just to show splash screen we can remove this at anytime
            await Future.delayed(const Duration(seconds: 2));
            Navigator.pushReplacementNamed(event2.context, RouteConsts.login);
          }
        }
      } else {
        print("uid null");
        //Waiting just to show splash screen we can remove this at anytime
        await Future.delayed(const Duration(seconds: 2));
        if (event2.context.mounted) {
          Navigator.pushReplacementNamed(event2.context, RouteConsts.login);
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
