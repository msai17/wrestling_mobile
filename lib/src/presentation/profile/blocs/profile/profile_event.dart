part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

final class ProfileInitialEvent extends ProfileEvent{}

final class ProfileGetLocalEvent extends ProfileEvent{}
final class ProfileExitEvent extends ProfileEvent{}

