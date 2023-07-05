import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/login_screen.dart';

//save api response

class SharedPrefrence {
  late String email;
  late String token;

  Future<bool> setEmail(String emailID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("email", emailID);
  }

  Future<String> getEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("email") ?? '';
  }

  Future<bool> setToken(String tokenID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("token", tokenID);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") ?? '';
  }

  Future<bool> tryAutoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("token")) {
      return false;
    } else {
      return true;
    }
  }

  static logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.off(() => LoginScreen());
  }
}
