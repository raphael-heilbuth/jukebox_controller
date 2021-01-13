import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/centered_message.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/componentes/progress.dart';
import 'package:jukebox_controller/http/web.clients/controles_webclient.dart';
import 'package:jukebox_controller/models/success.dart';

class Creditos extends StatefulWidget {
  static const String routeName = '/creditos';

  @override
  _CreditosState createState() => _CreditosState();
}

class _CreditosState extends State<Creditos> {
  final ControlesWebClient _webClientController = ControlesWebClient();

  int qtdCredito = 0;
  double valorCredito = 0.50;
  double valorPagar = 0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Créditos"),
      ),
      drawer: AppDrawer(),
      body: ListView(children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                title: const Text('Crédito'),
                subtitle: Text(
                  'Quantidade',
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
                trailing: new Column(
                  children: <Widget>[
                    new IconButton(
                        icon: new Icon(Icons.attach_money),
                        color: Colors.greenAccent,
                        onPressed: () {
                          _webClientController.addCredito(qtdCredito).then((result) {
                            setState(() {
                              qtdCredito = 0;
                              valorPagar = valorCredito * qtdCredito;
                            });
                          });
                        }
                        ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RawMaterialButton(
                      onPressed: () => {
                        setState(() {
                        qtdCredito--;
                        valorPagar = valorCredito * qtdCredito;
                      })},
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.remove,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                    Text(qtdCredito.toString(),
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    RawMaterialButton(
                      onPressed: () => {
                      setState(() {
                        qtdCredito++;
                        valorPagar = valorCredito * qtdCredito;
                      })
                      },
                      elevation: 2.0,
                      fillColor: Colors.white,
                      child: Icon(
                        Icons.add,
                      ),
                      padding: EdgeInsets.all(15.0),
                      shape: CircleBorder(),
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text('R\$ ' + valorPagar.toString(),
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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
