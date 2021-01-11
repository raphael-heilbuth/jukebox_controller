import 'dart:ffi';

class Musica {
  final String nome;
  final double duracao;

  Musica(
      this.nome,
      this.duracao
      );

  Musica.fromJson(Map<String, dynamic> json) :
        nome = json['NomeMusica'],
        duracao = json['Duracao'];

  Map<String, dynamic> toJson() =>
      {
        'NomeMusica' : nome,
        'Duracao': duracao,
      };

  @override
  String toString() {
    Duration d = Duration(seconds: this.duracao.round());

    int hour = d.inHours;
    int remainderMinutes = d.inMinutes.remainder(60);
    int remainderSeconds = d.inSeconds.remainder(60);

    return '${hour.toString().padLeft(2, '0')}:${remainderMinutes.toString().padLeft(2, '0')}:${remainderSeconds.toString().padLeft(2, '0')}';
  }
}