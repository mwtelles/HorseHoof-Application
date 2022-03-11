class Veterinario {
  int id = 0;
  String? tempoNoMercado;
  String? especializacao;
  int isEstudante = 0;

  Veterinario({id, tempoNoMercado, especializacao, isEstudante}) {
    id = id;
    tempoNoMercado = tempoNoMercado;
    especializacao = especializacao;
    isEstudante = isEstudante;
  }

  Veterinario.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isEstudante = json['is_estudante'];
    especializacao = json['especializacao'];
    tempoNoMercado = json['tempo_no_mercado'];
  }
}
