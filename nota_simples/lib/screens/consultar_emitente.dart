import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ConsultarEmitente extends StatefulWidget {
  const ConsultarEmitente({super.key});

  @override
  State<ConsultarEmitente> createState() => _ConsultarEmitenteState();
}

class _ConsultarEmitenteState extends State<ConsultarEmitente> {
  final String _userId = '';
  @override
  Future<void> consultarEmitente() async {
    String url =
        "https://invianf.com.br/ws/appNotaSimples/consultarEmitente.php";
    http.Response response;

    Map<String, String> body = {
      "apiPassword": "v4pZqfXa3r88SW3aPr",
      "userID": _userId
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

    Map<String, dynamic> resposta = json.decode(response.body);
    if (resposta["StatusCode"] == "200") {
      /*String usuario = resposta["Usuario"];
      String email = resposta["Email"];
      String telefone = resposta["Telefone"];
      String userId = resposta["UserID"];
      String ibge = resposta["ibge"];*/

      //Salvar no banco de dados local
      //DatabaseHelper.createCliente(resposta['telefoneTOMADOR']);

      // SALVANDO o userId com o SharedPereferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("UserId", resposta["UserID"]);

      EasyLoading.dismiss();
    } else {
      {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Usuario inexistente ou Senha invalida")));
        EasyLoading.dismiss();
      }
    }

    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Consultar Emitente"),
        ),
        body: const Column(
          children: [Text("Consultar Emitente")],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
