import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:students_attendance_management_app/core/constants.dart';
import 'package:students_attendance_management_app/feature/auth/domain/entity/user_entity.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/login_usecase.dart';
import 'package:students_attendance_management_app/feature/auth/domain/usecases/upload_profile_pic_usecase.dart';

import '../../../../../main_injection_container.dart';
import '../../../domain/usecases/get_user_usecase.dart';
import '../../../domain/usecases/sign_in_with_email_and_password_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithEmailAndPasswordUseCase signUp;
  final LoginUseCase login;
  final GetUserUseCase getUser;
  final UploadProfilePicUseCase upload;
  AuthBloc(
      {required this.upload,
      required this.getUser,
      required this.signUp,
      required this.login})
      : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) => _signUp(event));
    on<LoginEvent>((event, emit) => _login(event));
    on<PickImageEvent>((event, emit) => _changeProfilePicture(event));
    on<LogOutEvent>((event, emit) => _logout(event));
  }
  Future<void> _signUp(SignUpEvent event) async {
    try {
      //Creating the user in Firestore and registering them in Firebase Auth
      await signUp(
              email: event.email,
              password: event.password,
              userEntity: UserEntity(name: event.name, email: event.email))
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
      UserEntity user = const UserEntity();
      final Completer<void> completer = Completer<void>();
      getUser().listen((event) {
        user = event;
        completer.complete();
      })
        ..onError((e) {
          completer.complete();
          throw e;
        })
        ..onDone(() => completer.complete());
      await completer.future;
      if (event.context.mounted) {
        if (user.admin == true) {
          Navigator.popUntil(event.context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(
            event.context,
            RouteConsts.adminScreen,
            arguments: user,
          );
        } else {
          Navigator.popUntil(event.context, (route) => route.isFirst);
          Navigator.pushReplacementNamed(
            event.context,
            RouteConsts.home,
            arguments: user,
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      toast(message: e.message.toString());
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }

  Future<void> _changeProfilePicture(
    PickImageEvent event,
  ) async {
    try {
      await Permission.photos.request();
      final XFile? picker = await ImagePicker().pickImage(
        imageQuality: 80,
        source: ImageSource.gallery,
      );
      if (picker != null) {
        final croppedImage = await ImageCropper().cropImage(
          aspectRatio: const CropAspectRatio(ratioX: 0.1, ratioY: 0.1),
          sourcePath: picker.path,
        );
        if (croppedImage?.path != null) {
          //Upload image
          await upload(profilePic: croppedImage!.path, uid: event.uid);
        } else {
          toast(message: "Image must be cropped");
        }
      } else {
        toast(message: "No image picked");
      }
    } catch (e) {
      customPrint(message: e.toString());
      rethrow;
    }
  }

  Future<void> _logout(
    LogOutEvent event,
  ) async {
    try {
      await sl<FirebaseAuth>().signOut().then((value) {
        Navigator.popUntil(event.context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(event.context, RouteConsts.login);
      });
    } catch (e) {
      toast(message: e.toString());
      rethrow;
    }
  }
}
