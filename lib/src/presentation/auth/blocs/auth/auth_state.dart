import 'package:wrestling_hub/src/data/user/models/user.dart';

abstract class AuthState {

}

class AuthInitState extends AuthState {}

class AuthLoadingState extends AuthState {

}

class AuthSuccessState extends AuthState {
  final User user;
  AuthSuccessState(this.user);
}

class AuthWrongCodeState extends AuthState{
  final String? message;
  AuthWrongCodeState({this.message});
}

class AuthErrorState extends AuthState{
  final String? message;
  AuthErrorState({this.message});
}