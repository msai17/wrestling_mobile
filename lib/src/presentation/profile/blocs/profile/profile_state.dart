part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoggedState extends ProfileState{
  final User user;
  final Icon icon;

  ProfileLoggedState(this.user,this.icon);


  ProfileLoggedState copyWith({
    User? user,
    Icon? icon,
  }){
    return ProfileLoggedState(
        user ?? this.user,
        icon ?? this.icon
    );
  }

}

final class ProfileNoLoggedState extends ProfileState{}
