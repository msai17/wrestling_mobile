import 'dart:io';
import 'package:wrestling_hub/core/resources/data_state.dart';
import 'package:wrestling_hub/core/resources/data_state_auth.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';

abstract class UserRepository {
  Future<DataStateAuth<User>>confirmSmsCode(Map<String,dynamic> data);
  Future<DataState<User>>getUser(String token);
  Future<DataState<User>>getLocalUser();
  Future<DataState<String>>sendImageServer(File image);
  Future<DataState<User>>editUser(Map<String,dynamic> data);
  Future<DataState<bool>>deleteUser(String token);
}