import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';

class Configuracoes extends StatelessWidget {

  static const String routeName = '/configuracoes';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Configurações"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("Configurações"))
    );
  }
}