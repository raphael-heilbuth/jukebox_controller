import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';

class Controles extends StatelessWidget {

  static const String routeName = '/controles';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Controles"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("Controles"))
    );
  }
}