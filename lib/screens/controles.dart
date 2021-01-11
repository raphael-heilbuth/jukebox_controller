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
        Card(
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
                                  if (snapshot.hasData) {
                                    final snackBar = SnackBar(
                                      content: Text('Yay! A SnackBar!'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    // Find the Scaffold in the widget tree and use
                                    // it to show a SnackBar.
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }
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
                        Icons.remove,
                        size: 35.0,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    Text('10',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0)),
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
                                  if (snapshot.hasData) {
                                    final snackBar = SnackBar(
                                      content: Text('Yay! A SnackBar!'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    // Find the Scaffold in the widget tree and use
                                    // it to show a SnackBar.
                                    Scaffold.of(context).showSnackBar(snackBar);
                                  }
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
                        Icons.add,
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
}
