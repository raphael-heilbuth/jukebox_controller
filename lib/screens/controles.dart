import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/controles_webclient.dart';
import 'package:jukebox_controller/models/success.dart';

class Controles extends StatelessWidget {
  static const String routeName = '/controles';
  final ControlesWebClient _webClientController = ControlesWebClient();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Controles"),
      ),
      drawer: AppDrawer(),
      body: ListView(children: [
        CardVolume(webClientController: _webClientController),
        CardReproducao(webClientController: _webClientController),
      ]),
    );
  }
}

class CardVolume extends StatelessWidget {
  const CardVolume({
    Key key,
    @required ControlesWebClient webClientController,
  }) : _webClientController = webClientController, super(key: key);

  final ControlesWebClient _webClientController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shadowColor: Color(0x802196F3),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: const Text('Volume'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  onPressed: () => {
                    FutureBuilder<Success>(
                        future: _webClientController.volumeMenos(),
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
                              if (snapshot.hasData) {}
                              return CenteredMessage(
                                'No transactions found',
                                icon: Icons.warning,
                              );
                              break;
                          }

                          return CenteredMessage('Unknown error');
                        })
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.volume_down,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () => {
                    FutureBuilder<Success>(
                        future: _webClientController.volumeMais(),
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
                              if (snapshot.hasData) {}
                              return CenteredMessage(
                                'No transactions found',
                                icon: Icons.warning,
                              );
                              break;
                          }

                          return CenteredMessage('Unknown error');
                        })
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.volume_up,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardReproducao extends StatelessWidget {
  const CardReproducao({
    Key key,
    @required ControlesWebClient webClientController,
  }) : _webClientController = webClientController, super(key: key);

  final ControlesWebClient _webClientController;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shadowColor: Color(0x802196F3),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: const Text('Reprodução'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RawMaterialButton(
                  onPressed: () => {
                    FutureBuilder<Success>(
                        future: _webClientController.volumeMenos(),
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
                              if (snapshot.hasData) {}
                              return CenteredMessage(
                                'No transactions found',
                                icon: Icons.warning,
                              );
                              break;
                          }

                          return CenteredMessage('Unknown error');
                        })
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.pause,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () => {
                    FutureBuilder<Success>(
                        future: _webClientController.volumeMais(),
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
                              if (snapshot.hasData) {}
                              return CenteredMessage(
                                'No transactions found',
                                icon: Icons.warning,
                              );
                              break;
                          }

                          return CenteredMessage('Unknown error');
                        })
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.skip_next,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
