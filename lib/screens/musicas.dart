import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';

class Musicas extends StatelessWidget {

  static const String routeName = '/musicas';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Músicas"),
        ),
        drawer: AppDrawer(),
        body: _buildGrid()
    );
  }
}

Widget _buildGrid() => GridView.extent(
    maxCrossAxisExtent: 150,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    children: _buildGridTileList(6));

List<Container> _buildGridTileList(int count) => List.generate(
    count, (i) => Container(
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://i.pinimg.com/originals/0c/96/b1/0c96b19dc89ffdaa7ff737cfc04a095f.png')
        )
    ),
    alignment: Alignment.bottomCenter, // This aligns the child of the container
    child: Padding(
        padding: EdgeInsets.only(bottom: 10.0), //some spacing to the child from bottom
        child: Text('Hello', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
    )
)



);