import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/musicas_webclient.dart';
import 'package:jukebox_controller/models/artista.dart';
import 'package:jukebox_controller/models/musica.dart';

class ListaMusicas extends StatefulWidget {
  final Artista artista;

  ListaMusicas(this.artista);

  @override
  _ListaMusicasState createState() => _ListaMusicasState();
}

class _ListaMusicasState extends State<ListaMusicas> {
  final MusicasWebClient _webClient = MusicasWebClient();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Músicas - ' + widget.artista.nome),
      ),
      body: FutureBuilder<List<Musica>>(
        future: _webClient.retornaMusicas(widget.artista.nome),
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
              if(snapshot.hasData){
                final List<Musica> musicas = snapshot.data;
                if (musicas.isNotEmpty) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Musica musica = musicas[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            _reproduzirMusica(
                              _webClient,
                              widget.artista.nome,
                              musica.nome,
                              context,
                            );
                          },
                          child: ListTile(
                            leading: Icon(Icons.music_note),
                            title: Text(
                              musica.nome,
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              musica.toString(),
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: musicas.length,
                  );
                }
              }
              return CenteredMessage(
                'Nenhuma musica para esse artista',
                icon: Icons.music_off,
              );
              break;
          }

          return CenteredMessage('Unknown error');
        },
      ),
    );
  }

  Future<void> _reproduzirMusica(
      MusicasWebClient webClient,
      String artista,
      String musica,
      BuildContext context,
      ) async {
    final createCredito = await webClient
        .reproduzirMusicas(artista, musica)
        .catchError(
          (e) => _showSnackBar(context,
          message:
          'O tempo para reproduzir a música demorou muito. Operação cancelada!'),
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
        _showSnackBar(context, message: 'Música $musica adicionada a JukeBox');
      } else {
        _showSnackBar(context, message: 'Erro ao reproduzir a música $musica');
      }
    }
  }

  void _showSnackBar(BuildContext context, {String message = 'Error'}) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(message)));
  }

}