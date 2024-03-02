part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class MarkAttendanceEvent extends HomeEvent {
  final String name;
  final String uid;

  const MarkAttendanceEvent({required this.name, required this.uid});
  @override
  List<Object?> get props => [name, uid];
}
