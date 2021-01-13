import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/controles_webclient.dart';
import 'package:jukebox_controller/models/success.dart';

class Controles extends StatefulWidget {
  static const String routeName = '/controles';

  @override
  _ControlesState createState() => _ControlesState();
}

class _ControlesState extends State<Controles> {
  final ControlesWebClient _webClientController = ControlesWebClient();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Controles"),
      ),
      drawer: AppDrawer(),
      body: ListView(children: [
        Card(
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
                      onPressed: () {
                        _volumeMenos(
                          _webClientController,
                          context,
                        );
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
                      onPressed: () {
                        _volumeMais(
                          _webClientController,
                          context,
                        );
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
        ),
        Card(
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
                      onPressed: () {
                        _proximaMusica(
                          _webClientController,
                          context,
                        );
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
                            future: _webClientController.proximaMusica(),
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
        ),
      ]),
    );
  }

  Future<void> _volumeMais(
    ControlesWebClient webClient,
    BuildContext context,
  ) async {
    final createCredito = await webClient
        .volumeMais()
        .catchError(
          (e) => _showSnackBar(
            context,
            message:
                'O tempo para aumentar o volume demorou muito. Operação cancelada!',
          ),
        )
        .catchError(
          (error) => _showSnackBar(context, message: error.message),
        )
        .catchError(
          (error) => _showSnackBar(context),
        )
        .whenComplete(() => {});

    if (createCredito != null) {
      if (createCredito.sucesso) {
        _showSnackBar(context, message: 'Volume aumentado');
      } else {
        _showSnackBar(context, message: 'Erro ao aumentar volume');
      }
    }
  }

  Future<void> _volumeMenos(
    ControlesWebClient webClient,
    BuildContext context,
  ) async {
    final createCredito = await webClient
        .volumeMenos()
        .catchError(
          (e) => _showSnackBar(context,
              message:
                  'O tempo para diminuir o volume demorou muito. Operação cancelada!'),
        )
        .catchError(
          (error) => _showSnackBar(context, message: error.message),
        )
        .catchError(
          (error) => _showSnackBar(context),
        )
        .whenComplete(() => {});

    if (createCredito != null) {
      if (createCredito.sucesso) {
        _showSnackBar(context, message: 'Volume diminuido');
      } else {
        _showSnackBar(context, message: 'Erro ao diminuir volume');
      }
    }
  }

  Future<void> _proximaMusica(
    ControlesWebClient webClient,
    BuildContext context,
  ) async {
    final createCredito = await webClient
        .volumeMenos()
        .catchError(
          (e) => _showSnackBar(context,
              message:
                  'O tempo para pular a musica demorou muito. Operação cancelada!'),
        )
        .catchError(
          (error) => _showSnackBar(context, message: error.message),
        )
        .catchError(
          (error) => _showSnackBar(context),
        )
        .whenComplete(() => {});

    if (createCredito != null) {
      if (createCredito.sucesso) {
        _showSnackBar(context, message: 'Próxima música');
      } else {
        _showSnackBar(context, message: 'Erro ao pular música');
      }
    }
  }

  void _showSnackBar(BuildContext context, {String message = 'Error'}) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }
}
