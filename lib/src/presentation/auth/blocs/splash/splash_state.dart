part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

final class SplashInitialState extends SplashState {}

final class SplashLoggedState extends SplashState {

}

final class SplashFirstLaunchState extends SplashState {

}

final class SplashFailedState extends SplashState{
  final String message;

  SplashFailedState(this.message);
}
