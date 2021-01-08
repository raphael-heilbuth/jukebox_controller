import 'package:flutter/material.dart';
import 'package:jukebox_controller/routes/routes.dart';
import 'package:jukebox_controller/screens/configuracoes.dart';
import 'package:jukebox_controller/screens/controles.dart';
import 'package:jukebox_controller/screens/creditos.dart';
import 'package:jukebox_controller/screens/dashboard.dart';
import 'package:jukebox_controller/screens/musicas.dart';
import 'package:jukebox_controller/screens/relatorios.dart';

void main() {
  runApp(JukeBoxControlApp());
}

class JukeBoxControlApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Dashboard(),
      routes:  {
        Routes.dashboard: (context) => Dashboard(),
        Routes.creditos: (context) => Creditos(),
        Routes.controles: (context) => Controles(),
        Routes.musicas: (context) => Musicas(),
        Routes.relatorios: (context) => Relatorios(),
        Routes.configuracoes: (context) => Configuracoes(),
      },
    );
  }
}