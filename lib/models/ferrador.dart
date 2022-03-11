class Ferrador {
  int id = 0;
  String? associacao;
  String? qualificacao;
  int? isMembroAfb;

  Ferrador({id, associacao, qualificacao, isMembroAfb}) {
    id = id;
    associacao = associacao;
    qualificacao = qualificacao;
    isMembroAfb = isMembroAfb;
  }

  Ferrador.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    associacao = json['associacao'];
    qualificacao = json['qualificacao'];
    isMembroAfb = json['is_membro_afb'];
  }
}
