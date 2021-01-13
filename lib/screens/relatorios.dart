import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/componentes/floating_button.dart';
import 'package:jukebox_controller/routes/routes.dart';

class Relatorios extends StatelessWidget {

  static const String routeName = '/relatorios';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Relatórios"),
        ),
        floatingActionButton: FloatingButton(onClick: () {Navigator.pushReplacementNamed(context, Routes.creditos);}),
        drawer: AppDrawer(),
        body: Center(child: Text("Relatórios"))
    );
  }
}