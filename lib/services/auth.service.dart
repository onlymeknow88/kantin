import 'dart:convert';

import 'package:kantin/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  String baseUrl = 'http://103.183.75.223/api';

  Future<UserModel> register({
    String name,
    String username,
    String email,
    String password,
  }) async {
    var url = Uri.parse('$baseUrl/register');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'name': name,
      'username': username,
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      return user;
    } else {
      throw Exception('Gagal Register');
    }
  }

  Future<UserModel> login({
    String email,
    String password,
  }) async {
    final pref = await SharedPreferences.getInstance();
    var url = Uri.parse('$baseUrl/login');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];

      pref.setString('token', user.token);
      pref.setString('email', user.email);
      pref.setString('password', password);

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> logout({
    String token,
  }) async {
    var url = Uri.parse('$baseUrl/logout');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      final localStorage = await SharedPreferences.getInstance();
      localStorage.remove('token');
      localStorage.remove('email');
      localStorage.remove('password');
      return null;
    } else {
      throw Exception('Gagal Logout');
    }
  }

  Future<UserModel> autologin({
    String token,
    String email,
    String password,
  }) async {
    var url = Uri.parse('$baseUrl/login');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = jsonEncode({
      'email': email,
      'password': password,
    });

    var response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']);
      user.token = 'Bearer ' + data['access_token'];
      user.roles = data['roles'];

      return user;
    } else {
      throw Exception('Gagal Login');
    }
  }

  Future<UserModel> getUser({
    String token,
  }) async {
    var url = Uri.parse('$baseUrl/user');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      print(data);
      UserModel user = UserModel.fromJson(data['user']);
      user.roles = data['roles'];

      return user;
    } else {
      throw Exception('Get User');
    }
  }
}
