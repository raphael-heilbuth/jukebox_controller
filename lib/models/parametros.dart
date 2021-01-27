class Parametros {
  final String modo;
  final double valorCredito;
  final bool topMusicas;
  final bool randomMusicas;
  final bool youtubeMusicas;
  final int timeRandom;

  Parametros(
      this.modo,
      this.valorCredito,
      this.topMusicas,
      this.randomMusicas,
      this.youtubeMusicas,
      this.timeRandom,
      );

  Parametros.fromJson(Map<String, dynamic> json) :
        modo = json['modo'],
        valorCredito = json['valorCredito'],
        topMusicas = json['topMusicas'],
        randomMusicas = json['randomMusicas'],
        youtubeMusicas = json['youtubeMusicas'],
        timeRandom = json['timeRandom'];

  Map<String, dynamic> toJson() =>
      {
        'modo' : modo,
        'valorCredito': valorCredito,
        'topMusicas': topMusicas,
        'randomMusicas': randomMusicas,
        'youtubeMusicas': youtubeMusicas,
        'timeRandom': timeRandom,
      };
}