class Cavalo {
  String apelido;
  String sexo;
  String idade;
  String raca;

  Cavalo(
      {required this.apelido,
      required this.sexo,
      required this.idade,
      required this.raca});

  factory Cavalo.fromJson(Map<String, dynamic> json) {
    return Cavalo(
      apelido: json['apelido'],
      sexo: json['sexo'],
      idade: json['idade'],
      raca: json['raca'],
    );
  }
}
