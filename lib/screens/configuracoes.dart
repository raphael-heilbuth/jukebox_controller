import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jukebox_controller/componentes/drawer.dart';
import 'package:jukebox_controller/http/web.clients/parametros_webclient.dart';
import 'package:jukebox_controller/models/parametros.dart';
import 'package:jukebox_controller/util/sharedPref.dart';

class Configuracoes extends StatelessWidget {
  static const String routeName = '/configuracoes';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Configurações"),
      ),
      drawer: AppDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyCustomForm(),
            ),
          ),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final controllerTextIp = TextEditingController();
  final controllerTextValor = TextEditingController();
  final controllerTextTimeRandom = TextEditingController();
  final ParametrosWebClient _webClientParametros = ParametrosWebClient();

  SharedPref sharedPref = SharedPref();

  bool _valueRandom = false;
  bool _valueTop = false;
  bool _valueYoutube = false;
  int radioButtonItem = 1;
  int id = 1;

  void _onSetIp(String value) => setState(() => controllerTextIp.text = value);

  void _onSetValorCredito(String value) =>
      setState(() => controllerTextValor.text = value);

  void _onSetTimeRandom(String value) =>
      setState(() => controllerTextTimeRandom.text = value);

  void _onChangedRandom(bool value) => setState(() => _valueRandom = value);

  void _onChangedTop(bool value) => setState(() => _valueTop = value);

  void _onChangedYoutube(bool value) => setState(() => _valueYoutube = value);

  void _onChangedRadio(int value) => setState(
      () => {radioButtonItem = value, id = value});

  String ip = '';

  void initState() {
    super.initState();
    sharedPref.readString("ip").then((value) => _onSetIp(value));

    _webClientParametros.retornaParametros().then((value) => {
          _onSetValorCredito(value.valorCredito.toString()),
          _onSetTimeRandom((value.timeRandom ~/ 60000).toString()),
          _onChangedRandom(value.randomMusicas),
          _onChangedTop(value.topMusicas),
          _onChangedYoutube(value.youtubeMusicas),
          _onChangedRadio(value.modo == 'Ficha' ? 1: 2),
        });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            elevation: 2.0,
            shadowColor: Color(0x802196F3),
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              ListTile(
                title: const Text('Volume'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, bottom: 15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.settings),
                    hintText: 'Ex: 192.168.1.13',
                    labelText: 'IP JukeBox',
                  ),
                  controller: controllerTextIp,
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'O IP deve ser preenchido';
                    }
                    return null;
                  },
                ),
              ),
            ]),
          ),
          Card(
            elevation: 2.0,
            shadowColor: Color(0x802196F3),
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              ListTile(
                title: const Text('Volume'),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: [
                            Radio(
                              value: 1,
                              groupValue: id,
                              onChanged: (val) {
                                _onChangedRadio(val);
                              },
                            ),
                            Text('Ficha'),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: 2,
                              groupValue: id,
                              onChanged: (val) {
                                _onChangedRadio(val);
                              },
                            ),
                            Text('Livre'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: const FaIcon(FontAwesomeIcons.dollarSign),
                          hintText: 'Ex: 0,50',
                          labelText: 'Valor Crédito',
                        ),
                        controller: controllerTextValor,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'O IP deve ser preenchido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: new Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 15.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          icon: const FaIcon(FontAwesomeIcons.random),
                          hintText: 'Ex: 4',
                          labelText: 'Tempo Random(Min)',
                        ),
                        controller: controllerTextTimeRandom,
                        keyboardType: TextInputType.numberWithOptions(),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'O IP deve ser preenchido';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
          Card(
            elevation: 2.0,
            shadowColor: Color(0x802196F3),
            clipBehavior: Clip.antiAlias,
            child: Column(children: [
              ListTile(
                title: const Text('Volume'),
              ),
              SwitchListTile(
                title: const Text('Musicas randomicas'),
                value: _valueRandom,
                onChanged: _onChangedRandom,
                secondary: const FaIcon(FontAwesomeIcons.random),
              ),
              SwitchListTile(
                title: const Text('Top Musicas'),
                value: _valueTop,
                onChanged: _onChangedTop,
                secondary: const FaIcon(FontAwesomeIcons.chevronCircleUp),
              ),
              SwitchListTile(
                title: const Text('Youtube Musicas'),
                value: _valueYoutube,
                onChanged: _onChangedYoutube,
                secondary: const FaIcon(FontAwesomeIcons.youtube),
              ),
            ]),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false
                  // otherwise.
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    String ip = (controllerTextIp.text.contains('http:')
                        ? controllerTextIp.text
                        : 'http:\/\/' + controllerTextIp.text + ':8000\/');
                    sharedPref.writeString("ip", ip);

                    Parametros parametro = new Parametros(
                        radioButtonItem == 1 ? "Ficha" : "Livre",
                        double.parse(controllerTextValor.text),
                        _valueTop,
                        _valueRandom,
                        _valueYoutube,
                        (int.parse(controllerTextTimeRandom.text) * 60000).toInt());

                    _webClientParametros
                        .salvaParametros(parametro)
                        .then((retorno) => {
                              if (retorno.sucesso)
                                {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Configurações salvas com sucesso!')))
                                }
                              else
                                {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text(
                                          'Não foi possivel salvar as configurações'),
                                      backgroundColor: Colors.red))
                                }
                            });
                  }
                },
                child: Text('Salvar'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
