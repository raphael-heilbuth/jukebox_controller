import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/artista.dart';
import 'package:jukebox_controller/models/musica.dart';
import 'package:jukebox_controller/models/success.dart';
import 'package:jukebox_controller/util/sharedPref.dart';

class MusicasWebClient {
  SharedPref sharedPref;

  MusicasWebClient()  {
    this.sharedPref = SharedPref();
  }

  Future<List<Artista>> retornaArtistas() async {
    final Response response = await client.get(await sharedPref.readString('ip') + 'listaArtista').timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((dynamic json) => Artista.fromJson(json)).toList();
  }

  Future<List<Musica>> retornaMusicas(String artista) async {
    final Response response = await client.get(await sharedPref.readString('ip') + 'listaMusica' + '?Artista=' + artista).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((dynamic json) => Musica.fromJson(json)).toList();
  }

  Future<Success> reproduzirMusicas(String artista, String musica) async {
    final String selecionaMusica = jsonEncode({'Artista': artista, 'Musica': musica});

    final Response response = await client.post(await sharedPref.readString('ip') + 'selecionaMusica',
        headers: {'Content-type' : 'application/json'},
        body: selecionaMusica
    );

    return Success.fromJson(jsonDecode(response.body));
  }
}