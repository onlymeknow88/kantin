import 'package:flutter/material.dart';
import 'package:kantin/models/user_model.dart';
import 'package:kantin/services/auth.service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<bool> register({
    String name,
    String username,
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    String email,
    String password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );

      _user = user;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> logout({
    String token,
  }) async {
    try {
      await AuthService().logout(
        token: token,
      );

      _user = null;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
