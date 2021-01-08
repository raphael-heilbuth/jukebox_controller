import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';

class Relatorios extends StatelessWidget {

  static const String routeName = '/relatorios';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Relatórios"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("Relatórios"))
    );
  }
}