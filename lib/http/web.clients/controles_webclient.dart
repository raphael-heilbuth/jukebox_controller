import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/success.dart';

class ControlesWebClient {
  Future<Success> volumeMais() async {
    final Response response = await client.post(baseUrl + 'volumeMais').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> volumeMenos() async {
    final Response response = await client.post(baseUrl + 'volumeMenos').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> volumeMute() async {
    final Response response = await client.post(baseUrl + 'mute').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> addCredito(qtd) async {
    final String qtdCreditos = jsonEncode({'QtdCredito': qtd});

    final Response response = await client.post(baseUrl + 'credito',
        headers: {'Content-type' : 'application/json'},
        body: qtdCreditos
    ).timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      return Success.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'Ocorreu um erro ao realizar a transferência',
    401: 'Falha de autenticação',
    409: 'Transferência já realizada',
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}