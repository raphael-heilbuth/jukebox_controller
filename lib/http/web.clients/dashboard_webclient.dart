import 'dart:convert';

import 'package:http/http.dart';
import 'package:jukebox_controller/http/webclient.dart';
import 'package:jukebox_controller/models/dashboard.dart';
import 'package:jukebox_controller/util/sharedPref.dart';

class DashboardWebClient {
  SharedPref sharedPref;

  DashboardWebClient()  {
    this.sharedPref = SharedPref();
  }

  Future<DadosDashboard> retornaDadosDashboard() async {
    final uri = new Uri.http(await sharedPref.readString('ip'), '/dashboard');
    final Response response = await client.get(uri).timeout(Duration(seconds: 5));

    return DadosDashboard.fromJson(jsonDecode(response.body));
  }
}