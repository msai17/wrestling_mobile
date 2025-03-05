


import 'package:wrestling_hub/src/data/user/models/user.dart';
import 'package:wrestling_hub/src/data/user/data_source/local/user_data.dart';

class UserLocalDataSource {

  final UserData userService;
  UserLocalDataSource(this.userService);

  User getUser() {
    return userService.currentUser!;
  }

  void deleteUser() {
    userService.currentUser = null;
    userService.dropUserData();
  }



}

