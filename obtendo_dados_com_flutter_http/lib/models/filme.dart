class Filme {
  String? nome;
  String? imagem;

  Filme({
    this.nome,
    this.imagem,
  });

  Filme.fromJson(Map<String, dynamic> json) {
    nome = json['nome'].toString();
    imagem = json['imagem'].toString();
  }
}
