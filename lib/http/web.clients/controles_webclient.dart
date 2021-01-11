import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/success.dart';

class ControlesWebClient {
  Future<Success> volumeMais() async {
    final Response response = await client.post(baseUrl + 'mute').timeout(Duration(seconds: 5));

    return Success.fromJson(jsonDecode(response.body));
  }
}