import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';

class Creditos extends StatelessWidget {

  static const String routeName = '/creditos';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Créditos"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("Créditos"))
    );
  }
}