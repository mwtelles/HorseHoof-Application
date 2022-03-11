class Raca {
  int id;
  String nome;

  Raca({required this.id, required this.nome});

  factory Raca.fromJson(Map<String, dynamic> json) {
    return Raca(
      id: json['id'],
      nome: json['nome'],
    );
  }
}
