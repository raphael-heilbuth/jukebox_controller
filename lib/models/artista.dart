class Artista {
  final String nome;
  final String capa;

  Artista(
      this.nome,
      this.capa
      );

  Artista.fromJson(Map<String, dynamic> json) :
        nome = json['Artista'],
        capa = json['Capa'];

  Map<String, dynamic> toJson() =>
      {
        'Sucesso' : nome,
        'Capa': capa,
      };
}