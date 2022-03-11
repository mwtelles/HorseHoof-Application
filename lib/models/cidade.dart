import 'package:tenorio_app/models/estado.dart';

class Cidade {
  late int id;
  late String nome;
  late int estadoId;
  late Estado estado;

  constructorCidade(int id, String nome, int estadoId, Estado estado) {
    this.id = id;
    this.nome = nome;
    this.estadoId = estadoId;
    this.estado = estado;
  }

  Cidade.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    estadoId = json['estado_id'];
    estado = Estado.fromJson(json['estado']);
  }
}
