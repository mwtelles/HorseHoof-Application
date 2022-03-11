import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tenorio_app/models/user.dart';
import 'package:tenorio_app/pages/auth/login.dart';
import 'package:tenorio_app/services/api.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  late User user;
  late ApiService apiService;

  AuthProvider() {
    init();
  }

  Future<void> init() async {
    try {
      String token = await getToken();
      apiService = ApiService(token);
      var authUser = await apiService.getUserAuth();
      Map<String, dynamic> json = await jsonDecode(authUser);

      user = User.fromJson(json);
      isAuthenticated = true;
    } on Exception {
      await logOut();
    }

    notifyListeners();
  }

  Future<void> register(String? name, String? email, String? password) async {
    await apiService.register(name, email, password);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    String token = await apiService.login(email, password);
    await setToken(token);
    Map<String, dynamic> authUser =
        await jsonDecode(await apiService.getUserAuth());
    user = User.fromJson(authUser);
    isAuthenticated = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    await deleteToken();
    isAuthenticated = false;
    Get.to(() => const LoginScreen());
    notifyListeners();
  }

  Future<void> setToken(String setToken) async {
    final prefs = await SharedPreferences.getInstance();
    String token = jsonDecode(setToken)['access_token'];
    apiService.token = token;
    await prefs.setString('token', token);
    notifyListeners();
  }

  Future<String> getToken() async {
    var prefs = await SharedPreferences.getInstance();
    var prefsToken = prefs.getString('token');

    if (prefsToken != null && prefsToken != '') {
      return prefsToken;
    }
    return prefsToken.toString();
  }

  Future<void> deleteToken() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    notifyListeners();
  }

  Future<User> getUserAuth() async {
    user = User.fromJson(jsonDecode(await apiService.getUserAuth()));
    notifyListeners();
    return user;
  }
}
