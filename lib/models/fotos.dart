class Foto {
  int id;
  String path;
  String type;
  String pata;

  Foto({
    required this.id,
    required this.path,
    required this.type,
    required this.pata,
  });

  factory Foto.fromJson(Map<String, dynamic> json) {
    return Foto(
      id: json['id'],
      path: json['path'],
      type: json['type'],
      pata: json['pata'],
    );
  }
}
