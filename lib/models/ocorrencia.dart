import 'dart:ui';

import 'package:flutter/material.dart';

import 'cavalo.dart';
import 'fotos.dart';

class Ocorrencia {
  int id;
  String nome;
  String? anotacao;
  String estado;
  String cidade;
  int status;
  String createdAt;
  Cavalo cavalo;
  List<Foto> fotos;
  String? relatorioPath;

  Ocorrencia({
    required this.id,
    required this.nome,
    required this.estado,
    required this.cidade,
    required this.anotacao,
    required this.status,
    required this.createdAt,
    required this.cavalo,
    required this.fotos,
    required this.relatorioPath,
  });

  String get statusLabel {
    String label = '';
    if (status == 0) {
      label = 'Aguardando resposta';
    } else if (status == 1) {
      label = 'Respondido';
    } else if (status == 2) {
      label = 'Rejeitado';
    }
    return label;
  }

  Color get statusColor {
    Color color = Colors.white;
    if (status == 0) {
      color = Colors.blueAccent;
    } else if (status == 1) {
      color = Colors.green;
    } else if (status == 2) {
      color = Colors.red;
    }
    return color;
  }

  factory Ocorrencia.fromJson(Map<String, dynamic> json) {
    return Ocorrencia(
      id: json['id'],
      nome: json['nome'],
      estado: json['estado'],
      cidade: json['cidade'],
      anotacao: json['anotacao'],
      status: json['status'],
      createdAt: json['created_at'],
      cavalo: Cavalo.fromJson(json['cavalo']),
      fotos: (json['fotos'] as List).map((i) => Foto.fromJson(i)).toList(),
      relatorioPath: json['relatorio'],
    );
  }
}
