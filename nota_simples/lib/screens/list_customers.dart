import 'dart:convert';
//import 'package:abo_rs/screens/cadastro_clientes.dart';
import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import "package:abo_rs/Utils/constants.dart";
import 'package:http/http.dart' as http;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:badges/badges.dart' as badges;
import 'package:nota_simples/screens/change_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cadastro_clientes.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  bool isSorted = false;
  //final TextEditingController _telefoneController = TextEditingController();
  List<dynamic>? results;

  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _cliIdController = TextEditingController();
  final TextEditingController _coddefinido = TextEditingController();
  final TextEditingController _ibgeController = TextEditingController();
  final TextEditingController _logController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _paisdefinido = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  String? _userId = "7";
  //CONTROLLER DO ENDEREÇO
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    _recuperar();
    recuperarDados();

    super.initState();
  }

  //MENU DE BOTÕES
  Widget floatRegister() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const CadastroClientes()));
      },
      heroTag: "btn1",
      tooltip: 'First button',
      child: const Icon(Icons.add),
    );
  }

  Widget floatEdit() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    recuperacaoSenha(senha: 'senha', usuario: 'usuario')));
      },
      heroTag: "btn2",
      tooltip: 'Second button',
      child: const Icon(Icons.edit),
    );
  }

  /*sort() {
    if (!isSorted) {
      results!
          .sort((a, b) => a.RazaoSocialTomador.compareTo(b.RazaoSocialTomador));
    } else {
      results = results!.reversed.toList();
    }
  }*/

  List<String> titular = [];

  Future<void> recuperarDados() async {
    //ENDPOINT
    String url = "https://invianf.com.br/ws/appNotaSimples/listarClientes.php";
    http.Response response;

    //JSON CHAMADA
    Map<String, String> body = {
      "apiPassword": "4pZqfXa3r88SW3aPr",
      "UserID": _userId!
    };

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    //AGUARDAR O RESPONSE
    response = await http.post(Uri.parse(url),
        body: json.encode(body), headers: headers);

    if (kDebugMode) {
      print(response.body);
    }

    //final responseB = await response.body.readAsString();
    Map<String, dynamic> resposta = json.decode(response.body);

    if (resposta["StatusCode"] == "200") {
      setState(() {
        results = resposta["Results"];
        debugPrint(results?[0]["User_id"].toString());
        debugPrint(results?[0]["RazaoSocialTomador"].toString());
        //debugPrint("recuperar ${recuperarDados()}");
        //EasyLoading.dismiss();
      });
      //debugPrint(resposta["RazaoSocialTomador"]);
      //debugPrint("Length ${results.length}");
      //debugPrint("recuperar ${recuperarDados()}");
      //debugPrint("user_ID $_userId");
    } else {
      debugPrint("NÃO SUCESSOs");
    }
  }

  //RECUPERANDO O VALOR DA CHAVE (USERID) UTILIZANDO SHARED PREFERNCES
  _recuperar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString("UserId");
    });
    //debugPrint("Shared $_userId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Clientes"),
          backgroundColor: Colors.orange,
          /*actions: [
            IconButton(
              onPressed: () => sort(),
              icon: const Icon(Icons.swap_vert_circle),
            )
          ],*/
          //backgroundColor: corPrincipal,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //BOTÃO A-Z
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          results!.sort((a, b) => a["RazaoSocialTomador"]
                              .toString()
                              .toLowerCase()
                              .compareTo(b["RazaoSocialTomador"]
                                  .toString()
                                  .toLowerCase()));
                        });
                      },
                      child: const Text("A-Z")),
                  const Padding(padding: EdgeInsets.all(10)),
                  //BOTÃO Z-A
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          results!.sort((c, d) => d.toString().compareTo(c));
                        });
                      },
                      child: const Text("Z-A")),
                  ElevatedButton(
                    onPressed: () {
                      showSearch(context: context, delegate: CustomSearch());
                    },
                    child: const TextField(
                      decoration: InputDecoration(
                          labelText: "Pesquisa CNPJ OU CPF",
                          prefix: Icon(Icons.search)),
                    ),
                  )
                ],
              ),
            ),
            results != null
                ? Expanded(
                    flex: 9,
                    child: ListView.separated(
                      itemCount: results!.length,
                      itemBuilder: (BuildContext context, int index) {
                        //String cpfCnpj = results![index]["CpfCnpjTomador"];
                        //VERIFICANDO SE RESULTS É NULO
                        //SE FOR NULO

                        return ListTile(
                          leading: badges.Badge(
                            badgeContent: Text(results![index]["cli_id"]),
                            child: Image.asset("images/mulher.png"),
                          ) /*Image.asset("images/mulher.png")*/,
                          title: /*Text(results[index]["DDDTomador"] +
                          results[index]["TelefoneTomador"]),*/
                              Text(results![index]["RazaoSocialTomador"] +
                                  "\n" +
                                  results![index]["CpfCnpjTomador"] +
                                  "\n" +
                                  results![index]["DescricaoCidadeTomador"]),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    ),
                  )
                : Container(),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedFloatingActionButton(
              //Fab list
              fabButtons: <Widget>[floatRegister(), floatEdit()],
              //key : key,
              colorStartAnimation: const Color.fromARGB(255, 177, 132, 37),
              colorEndAnimation: Colors.red,
              animatedIconData: AnimatedIcons.menu_close //To principal button
              ),
        ),

        /*floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const CadastroClientes()));
          },
        ),*/
        //bottomNavigationBar: BottomAppBar(child: Container(height: 50.0)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked);
  }
}

class CustomSearch extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  /*Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];

    for(var in var) {
      if()
    }

  }*/

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }
}
