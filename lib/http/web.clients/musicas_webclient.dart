import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/artista.dart';
import 'package:jukebox_controller/models/musica.dart';

class MusicasWebClient {
  Future<List<Artista>> retornaArtistas() async {
    final Response response = await client.get(baseUrl + 'listaArtista').timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((dynamic json) => Artista.fromJson(json)).toList();
  }

  Future<List<Musica>> retornaMusicas(String artista) async {
    final Response response = await client.get(baseUrl + 'listaMusica' + '?Artista=' + artista).timeout(Duration(seconds: 5));
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson.map((dynamic json) => Musica.fromJson(json)).toList();
  }
}