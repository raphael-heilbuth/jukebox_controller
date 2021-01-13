import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/musicas_webclient.dart';
import 'package:jukebox_controller/models/artista.dart';
import 'package:jukebox_controller/screens/lista_musicas.dart';

class Musicas extends StatelessWidget {
  static const String routeName = '/musicas';
  final MusicasWebClient _webClientMusicas = MusicasWebClient();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Músicas"),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Artista>>(
        future: _webClientMusicas.retornaArtistas(),
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
                final List<Artista> artistas = snapshot.data;
                if (artistas.isNotEmpty) {
                  return GridView.builder(
                      itemCount: snapshot.data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4),
                      padding: const EdgeInsets.all(4),
                      itemBuilder: (context, index) {
                        final Artista artista = artistas[index];
                        return _BuildGridTileList(artista, onClick: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ListaMusicas(artista)));
                        });
                      });
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

class _BuildGridTileList extends StatelessWidget {
  final Artista artista;
  final Function onClick;

  _BuildGridTileList(this.artista, {@required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(),
      child: new Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image:
                    NetworkImage('http://192.168.15.29:8000/' + artista.capa))),
        alignment: Alignment.bottomCenter,
        // This aligns the child of the container
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          //some spacing to the child from bottom
          child: Stack(
            children: <Widget>[
              // Stroked text as border.
              Text(
                artista.nome,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 2
                    ..color = Colors.black54,
                ),
              ),
              // Solid text as fill.
              Text(
                artista.nome,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
