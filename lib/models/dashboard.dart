class DadosDashboard {
  final int totalMusica;
  final int musicasTocadas;
  final int totalTocadas;

  DadosDashboard(
      this.totalMusica,
      this.musicasTocadas,
      this.totalTocadas
      );

  DadosDashboard.fromJson(Map<String, dynamic> json) :
        totalMusica = json['TotalMusicas'],
        musicasTocadas = json['MusicasTocadas'],
        totalTocadas = json['TotalTocadas'];

  Map<String, dynamic> toJson() =>
      {
        'TotalMusicas' : totalMusica,
        'MusicasTocadas': musicasTocadas,
        'TotalTocadas': totalTocadas,
      };
}