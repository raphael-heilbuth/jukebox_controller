import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/success.dart';
import 'package:jukebox_controller/util/sharedPref.dart';

class ControlesWebClient {
  SharedPref sharedPref;

  ControlesWebClient()  {
    this.sharedPref = SharedPref();
  }

  Future<Success> volumeMais() async {
    final Response response = await client.post(await sharedPref.readString('ip') + 'volumeMais').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> volumeMenos() async {
    final Response response = await client.post(await sharedPref.readString('ip') + 'volumeMenos').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> volumeMute() async {
    final Response response = await client.post(await sharedPref.readString('ip') + 'mute').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> proximaMusica() async {
    final Response response = await client.get(await sharedPref.readString('ip') + 'proxima').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }

  Future<Success> addCredito(qtd) async {
    final String qtdCreditos = jsonEncode({'QtdCredito': qtd});

    final Response response = await client.post(await sharedPref.readString('ip') + 'credito',
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