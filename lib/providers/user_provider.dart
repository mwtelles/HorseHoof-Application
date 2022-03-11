import 'package:flutter/material.dart';
import 'package:tenorio_app/services/api.dart';

import 'auth_provider.dart';

class UserProvider extends ChangeNotifier {
  late ApiService apiService;
  late AuthProvider authProvider;

  UserProvider(this.authProvider) {
    apiService = ApiService(authProvider.apiService.token);
    init();
  }

  Future init() async {
    getUserAuth();
    notifyListeners();
  }

  Future<void> getUserAuth() async {
    try {
      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }

  Future<dynamic> updateUser(json) async {
    try {
      await apiService.updateUser(json);
      await authProvider.getUserAuth();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> updateProfileImage(image) async {
    try {
      await apiService.updateProfileImage(image);
      await authProvider.getUserAuth();
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
