import 'package:flutter/material.dart';
import 'package:tenorio_app/models/cidade.dart';
import 'package:tenorio_app/services/api.dart';

import 'auth_provider.dart';

class CidadeProvider extends ChangeNotifier {
  List<Cidade> cidades = [];
  List<Cidade> searchableDropDown = [];
  late ApiService apiService;
  AuthProvider authProvider;

  CidadeProvider(this.authProvider) {
    apiService = ApiService(authProvider.apiService.token);
    init();
  }

  Future init() async {
    cidades = await apiService.fetchCidades();
    notifyListeners();
  }

  Future<void> refreshCidades() async {
    cidades = await apiService.fetchCidades();
    notifyListeners();
  }

  void updateSearchableDropDown(value) {
    searchableDropDown = value;
    notifyListeners();
  }

  Future<void> searchCidades(List<Cidade> cidades) async {
    await refreshCidades();
    this.cidades = cidades;
    notifyListeners();
  }
}
