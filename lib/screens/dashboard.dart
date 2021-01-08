import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';

class Dashboard extends StatelessWidget {

  static const String routeName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        drawer: AppDrawer(),
        body: Center(child: Text("Dashboard"))
    );
  }
}