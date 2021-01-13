import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:jukebox_controller/componentes/floating_button.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/dashboard_webclient.dart';
import 'package:jukebox_controller/models/dashboard.dart';
import 'package:jukebox_controller/routes/routes.dart';
import 'package:jukebox_controller/screens/musicas.dart';

class Dashboard extends StatelessWidget {
  static const String routeName = '/dashboard';
  final DashboardWebClient _webClientDashboard = DashboardWebClient();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Dashboard"),
        ),
        floatingActionButton: FloatingButton(onClick: () {Navigator.pushReplacementNamed(context, Routes.creditos);}),
        drawer: AppDrawer(),
        body: FutureBuilder<DadosDashboard>(
          future: _webClientDashboard.retornaDadosDashboard(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress();
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final DadosDashboard dashboard = snapshot.data;
                  return StaggeredGridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 12.0,
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    children: <Widget>[
                      _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('Total Musicas',
                                        style: TextStyle(color: Colors.blueAccent)),
                                    Text(dashboard.totalMusica.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 34.0))
                                  ],
                                ),
                                Material(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(24.0),
                                    child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Icon(Icons.music_note_outlined,
                                              color: Colors.white, size: 30.0),
                                        )))
                              ]),
                        ),
                        onTap: () => Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => Musicas())),
                      ),
                      _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Material(
                                    color: Colors.teal,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Icon(Icons.queue_music_outlined,
                                          color: Colors.white, size: 30.0),
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                Text(dashboard.musicasTocadas.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0)),
                                Text('Musicas reproduzidas', style: TextStyle(color: Colors.black45)),
                              ]),
                        ),
                      ),
                      _buildTile(
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Material(
                                    color: Colors.amber,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.queue_music_sharp,
                                          color: Colors.white, size: 30.0),
                                    )),
                                Padding(padding: EdgeInsets.only(bottom: 16.0)),
                                Text(dashboard.totalTocadas.toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20.0)),
                                Text('Total Reproduzidas', style: TextStyle(color: Colors.black45)),
                              ]),
                        ),
                      ),
                    ],
                    staggeredTiles: [
                      StaggeredTile.extent(2, 110.0),
                      StaggeredTile.extent(1, 180.0),
                      StaggeredTile.extent(1, 180.0),
                    ],
                  );
                }
                return CenteredMessage(
                  'No transactions found',
                  icon: Icons.warning,
                );
                break;
            }

            return CenteredMessage('Unknown error');
          },
        )
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: InkWell(
            // Do onTap() if it isn't null, otherwise do print()
            onTap: onTap != null
                ? () => onTap()
                : () {
                    print('Not set yet');
                  },
            child: child));
  }
}
