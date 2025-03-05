import 'package:shared_preferences/shared_preferences.dart';
import 'package:wrestling_hub/src/data/user/models/user.dart';

class UserData {

  SharedPreferences? prefs;
  static UserData instance = UserData();
  User? currentUser;

   initStorage() async {
    prefs = await SharedPreferences.getInstance();
  }

  bool? isLogged() {
    return prefs!.containsKey("accessToken");
  }

  bool isFirstLaunch() {
    return prefs!.containsKey("isFirstLaunch");
  }

  String? getAccessToken() {
    return prefs!.getString("accessToken");
  }

  void setFirstLaunch() {
    prefs!.setBool("isFirstLaunch", true);
  }

  void setAccessToken(String val) {
    prefs!.setString("accessToken", val);
  }

  void dropUserData()  {
    prefs!.remove("accessToken");
  }

}