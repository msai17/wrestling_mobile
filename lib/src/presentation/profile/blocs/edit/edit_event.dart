part of 'edit_bloc.dart';

sealed class EditEvent {

}

final class EditInitEvent extends EditEvent {}

final class EditGetLocalEvent extends EditEvent {

}

final class EditSelectImageEvent extends EditEvent {
  final BuildContext context;
  final bool isCamera;

  EditSelectImageEvent(this.context,this.isCamera);
}

final class EditProfileEvent extends EditEvent {
  final String firstName;
  final String lastName;
  final String patronymic;

  EditProfileEvent(this.firstName, this.lastName, this.patronymic);
}

final class EditDeleteProfileEvent extends EditEvent {
  final BuildContext context;

  EditDeleteProfileEvent(this.context);
}
