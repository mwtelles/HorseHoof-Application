import 'package:flutter/material.dart';
import 'package:tenorio_app/models/ocorrencia.dart';
import 'package:tenorio_app/services/api.dart';

import 'auth_provider.dart';

class OcorrenciaProvider extends ChangeNotifier {
  List<Ocorrencia> ocorrencias = [];
  late ApiService apiService;
  AuthProvider authProvider;
  OcorrenciaProvider(this.authProvider) {
    apiService = ApiService(authProvider.apiService.token);
    init();
  }

  Future init() async {
    ocorrencias = await apiService.fetchOcorrencias();
    notifyListeners();
  }

  Future<void> refreshOcorrencias() async {
    try {
      ocorrencias = await apiService.fetchOcorrencias();
      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }

  Future<void> searchOcorrencias(List<Ocorrencia> ocorrencias) async {
    try {
      await refreshOcorrencias();
      this.ocorrencias = ocorrencias;
      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }

  Future<Ocorrencia> addOcorrencia(json) async {
    Ocorrencia addedOcorrencia = await apiService.addOcorrencia(json);
    ocorrencias.add(addedOcorrencia);
    notifyListeners();
    return addedOcorrencia;
  }

  Future<void> updateOcorrencia(Ocorrencia ocorrencia) async {
    try {
      Ocorrencia updatedOcorrencia =
          await apiService.updateOcorrencia(ocorrencia);
      int index = ocorrencias.indexOf(ocorrencia);
      ocorrencias[index] = updatedOcorrencia;

      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }

  Future<void> deleteOcorrencia(Ocorrencia category) async {
    try {
      await apiService.deleteOcorrencia(category.id);

      ocorrencias.remove(category);
      notifyListeners();
    } on Exception {
      await authProvider.logOut();
    }
  }
}
