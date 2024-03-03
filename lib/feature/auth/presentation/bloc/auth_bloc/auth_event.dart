part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class SignUpEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final BuildContext context;

  const SignUpEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [name, email, password, context];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginEvent({
    required this.email,
    required this.password,
    required this.context,
  });
  @override
  List<Object?> get props => [email, password, context];
}

class PickImageEvent extends AuthEvent {
  final String uid;

  const PickImageEvent({required this.uid});
  @override
  List<Object?> get props => [uid];
}

class LogOutEvent extends AuthEvent {
  final BuildContext context;

  const LogOutEvent({required this.context});
  @override
  List<Object?> get props => [context];
}
