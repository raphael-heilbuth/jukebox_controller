import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/parametros.dart';
import 'package:jukebox_controller/models/success.dart';
import 'package:jukebox_controller/util/sharedPref.dart';

class ParametrosWebClient {
  SharedPref sharedPref;

  ParametrosWebClient()  {
    this.sharedPref = SharedPref();
  }

  Future<Parametros> retornaParametros() async {
    final Response response = await client.get(await sharedPref.readString('ip') + 'getParametro').timeout(Duration(seconds: 5));

    return Parametros.fromJson(jsonDecode(response.body));
  }

  Future<Success> salvaParametros(Parametros parametros) async {
    final Response response = await client.post(await sharedPref.readString('ip') + 'setParametro',
        headers: {'Content-type' : 'application/json'},
        body: jsonEncode(parametros.toJson()),
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