import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/musicas_webclient.dart';
import 'package:jukebox_controller/models/artista.dart';
import 'package:jukebox_controller/models/musica.dart';
import 'package:jukebox_controller/models/success.dart';

class ListaMusicas extends StatefulWidget {
  final Artista artista;

  ListaMusicas(this.artista);

  @override
  _ListaMusicasState createState() => _ListaMusicasState();
}

class _ListaMusicasState extends State<ListaMusicas> {
  final MusicasWebClient _webClient = MusicasWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          onTap: () => FutureBuilder<Success>(
                              future: _webClient.reproduzirMusicas(widget.artista.nome, musica.nome),
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
                              }),
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
                'No transactions found',
                icon: Icons.warning,
              );
              break;
          }

          return CenteredMessage('Unknown error');
        },
      ),
    );
  }
}