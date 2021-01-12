import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/dashboard.dart';

class DashboardWebClient {
  Future<DadosDashboard> retornaDadosDashboard() async {
    final Response response = await client.get(baseUrl + 'dashboard').timeout(Duration(seconds: 5));

    return DadosDashboard.fromJson(jsonDecode(response.body));
  }
}