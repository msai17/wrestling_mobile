import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class AuthConfirmEvent extends AuthEvent {
  final String number;
  final String code;
  AuthConfirmEvent(this.number, this.code);
}