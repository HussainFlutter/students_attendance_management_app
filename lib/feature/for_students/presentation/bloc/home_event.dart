part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class MarkAttendanceEvent extends HomeEvent {
  final String name;
  final String uid;
  final String email;

  const MarkAttendanceEvent(
      {required this.email, required this.name, required this.uid});
  @override
  List<Object?> get props => [name, uid, email];
}

class CheckAttendanceEvent extends HomeEvent {
  final String uid;
  final String email;

  const CheckAttendanceEvent({required this.uid, required this.email});

  @override
  List<Object?> get props => [uid, email];
}

class SendApplicationEvent extends HomeEvent {
  final String paragraph;
  final String uid;
  final String name;
  final String email;
  final BuildContext context;

  const SendApplicationEvent({
    required this.uid,
    required this.name,
    required this.paragraph,
    required this.context,
    required this.email,
  });
  @override
  List<Object?> get props => [paragraph, uid, name, context, email];
}
