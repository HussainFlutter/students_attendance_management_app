part of 'splash_bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();
  @override
  List<Object?> get props => [];
}

class IsLoginEvent extends SplashEvent {
  final BuildContext context;

  const IsLoginEvent({required this.context});

  @override
  List<Object?> get props => [context];
}
