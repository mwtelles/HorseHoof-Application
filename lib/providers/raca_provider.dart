import 'package:flutter/material.dart';
import 'package:tenorio_app/models/raca.dart';
import 'package:tenorio_app/services/api.dart';

import 'auth_provider.dart';

class RacaProvider extends ChangeNotifier {
  List<Raca> racas = [];
  late ApiService apiService;
  AuthProvider authProvider;

  RacaProvider(this.authProvider) {
    apiService = ApiService(authProvider.apiService.token);
    init();
  }

  Future init() async {
    racas = await apiService.fetchRacas();
    notifyListeners();
  }

  Future<void> refreshRacas() async {
    racas = await apiService.fetchRacas();
    notifyListeners();
  }
}
