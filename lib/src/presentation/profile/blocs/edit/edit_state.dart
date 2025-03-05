part of 'edit_bloc.dart';

sealed class EditState {}

final class EditInitialState extends EditState {
  EditInitialState();
}

final class EditLoadingState extends EditState {
  EditLoadingState();
}

final class EditFailedState extends EditState {
  final String message;
  EditFailedState({required this.message});
}

final class EditLocalUserState extends EditState {
  User user;
  File? image;
  EditLocalUserState({required this.user,required this.image});
}

final class EditSuccessState extends EditState {
  final String message;
  EditSuccessState({required this.message});
}
