import 'package:tenorio_app/models/cidade.dart';

class Estado {
  int id;
  String uf;
  String nome;
  List<Cidade>? cidades = [];

  Estado({
    required this.id,
    required this.uf,
    required this.nome,
    required this.cidades,
  });

  factory Estado.fromJson(Map<String, dynamic> json) {
    return Estado(
      id: json['id'],
      uf: json['UF'],
      nome: json['nome'],
      cidades: json['cidades'] != null
          ? json['cidades']
              .map<Cidade>((cidade) => Cidade.fromJson(cidade))
              .toList()
          : json['cidades'],
    );
  }
}
