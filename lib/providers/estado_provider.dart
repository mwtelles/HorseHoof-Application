import 'package:flutter/material.dart';
import 'package:tenorio_app/models/estado.dart';
import 'package:tenorio_app/services/api.dart';

import 'auth_provider.dart';

class EstadoProvider extends ChangeNotifier {
  List<Estado> estados = [];
  late ApiService apiService;
  late AuthProvider authProvider;

  EstadoProvider(this.authProvider) {
    apiService = ApiService(authProvider.apiService.token);

    init();
  }

  Future init() async {
    estados = await apiService.fetchEstados();
    notifyListeners();
  }

  Future<void> refreshEstados() async {
    try {
      estados = await apiService.fetchEstados();
      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }

  Future<void> searchEstados(List<Estado> estados) async {
    try {
      await refreshEstados();
      this.estados = estados;
      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }
}
