import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/componentes/response_dialog.dart';
import 'package:jukebox_controller/http/web.clients/controles_webclient.dart';
import 'package:intl/intl.dart';

class Creditos extends StatefulWidget {
  static const String routeName = '/creditos';

  @override
  _CreditosState createState() => _CreditosState();
}

class _CreditosState extends State<Creditos> {
  final ControlesWebClient _webClientController = ControlesWebClient();
  final oCcy = new NumberFormat("#,##0.00", "pt_BR");
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
          elevation: 2.0,
          shadowColor: Color(0x802196F3),
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
                          _addCredito(
                            _webClientController,
                            qtdCredito,
                            context,
                          );
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RawMaterialButton(
                          onPressed: () => {
                            setState(() {
                              qtdCredito -= 5;
                              valorPagar = valorCredito * qtdCredito;
                            })
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.remove,
                                size: 10,
                              ),
                              Text(
                                '5',
                                style:
                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                          constraints:  BoxConstraints.tight(Size.fromRadius(24)) ,
                        ),
                        RawMaterialButton(
                          onPressed: () => {
                            setState(() {
                              qtdCredito--;
                              valorPagar = valorCredito * qtdCredito;
                            })
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Icon(
                            Icons.remove,
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                    Text(
                      qtdCredito.toString(),
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
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
                        RawMaterialButton(
                          onPressed: () => {
                            setState(() {
                              qtdCredito += 5;
                              valorPagar = valorCredito * qtdCredito;
                            })
                          },
                          elevation: 2.0,
                          fillColor: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.add,
                                size: 10,
                              ),
                              Text(
                                '5',
                                style:
                                TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                          constraints:  BoxConstraints.tight(Size.fromRadius(24)) ,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.only(
                    right: 20.0, left: 20.0, bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'R\$ ' + oCcy.format(valorPagar),
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
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

  Future<void> _addCredito(
    ControlesWebClient webClient,
    int creditos,
    BuildContext context,
  ) async {
    final createCredito = await webClient
        .addCredito(creditos)
        .catchError(
          (e) => _showFailureMessage(
            context,
            message: 'O tempo para inserir crédito demorou muito e não foi salvo',
          ),
          test: (e) => e is TimeoutException,
        )
        .catchError(
          (error) => _showFailureMessage(context, message: error.message),
          test: (error) => error is HttpException,
        )
        .catchError(
          (error) => _showFailureMessage(context),
          test: (error) => error is Exception,
        )
        .whenComplete(() => setState(() => {}));

    if (createCredito != null) {
      if (createCredito.sucesso) {
        await showDialog(
          context: context,
          builder: (_) => SuccessDialog('Crédito adicionado'),
        );

        setState(() {
          qtdCredito = 0;
          valorPagar = valorCredito * qtdCredito;
        });
      } else {
        _showFailureMessage(context, message: 'Erro ao inserir crédito');
      }
    }
  }

  void _showFailureMessage(
    BuildContext context, {
    String message = 'Erro desconhecido',
  }) {
    showDialog(
      context: context,
      builder: (_) => FailureDialog(message),
    );
  }
}
