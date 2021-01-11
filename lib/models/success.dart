class Success {
  final bool sucesso;

  Success(
      this.sucesso
      );

  Success.fromJson(Map<String, dynamic> json) :
        sucesso = json['Sucesso'];

  Map<String, dynamic> toJson() =>
      {
        'Sucesso' : sucesso
      };
}