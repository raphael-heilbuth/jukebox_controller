import 'package:flutter/material.dart';
import 'package:jukebox_controller/routes/routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                  children: <Widget>[
                    Image(
                      image: new AssetImage('images/Logo.png'),
                      width: 35,
                    ),
                    Text(
                      'NodeJukeBox',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ]
              ),
            ),
            _createDrawerItem(
              icon: Icons.dashboard,
              title: 'Dashboard',
              onTap: () => Navigator.pushReplacementNamed(context, Routes.dashboard)
            ),
            _createDrawerItem(
              icon: Icons.monetization_on,
              title: 'Créditos',
              onTap: () => Navigator.pushReplacementNamed(context, Routes.creditos)
            ),
            _createDrawerItem(
              icon: Icons.control_camera,
              title: 'Controles',
              onTap: () => Navigator.pushReplacementNamed(context, Routes.controles)
            ),
            _createDrawerItem(
                icon: Icons.queue_music,
              title: 'Músicas',
              onTap: () => Navigator.pushReplacementNamed(context, Routes.musicas)
            ),
            _createDrawerItem(
              icon: Icons.receipt_long,
              title: 'Relatórios',
              onTap: () => Navigator.pushReplacementNamed(context, Routes.relatorios)
            ),
            _createDrawerItem(
              icon: Icons.settings,
              title: 'Configurações',
              onTap: () => Navigator.pushReplacementNamed(context, Routes.configuracoes)
            ),
          ],
        ),
    );
  }
}

Widget _createDrawerItem(
    {IconData icon, String title, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(title),
        )
      ],
    ),
    onTap: onTap,
  );
}