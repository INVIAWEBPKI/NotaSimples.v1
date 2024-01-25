import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:nota_simples/screens/consultar_emitente.dart';
import 'package:nota_simples/screens/homePage.dart';
import 'package:nota_simples/screens/login.dart';
import 'package:nota_simples/widgets/admob.dart';
import 'package:nota_simples/widgets/configuracoes.dart';
import 'cadastrar_servico.dart';
import 'cadastro_clientes.dart';
import 'list_customers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();

  Widget floatConfiguracao() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Configuracoes()));
      },
      heroTag: "btn1",
      tooltip: 'First button',
      child: const Icon(Icons.settings),
    );
  }

  Widget floatLogout() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const Login()));
      },
      heroTag: "btn2",
      tooltip: 'Second button',
      child: const Icon(Icons.logout),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nota Simples'),
        backgroundColor: Colors.orange,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimatedFloatingActionButton(
            //Fab list
            fabButtons: <Widget>[floatConfiguracao(), floatLogout()],
            //key : key,
            colorStartAnimation: const Color.fromARGB(255, 177, 132, 37),
            colorEndAnimation: Colors.red,
            animatedIconData: AnimatedIcons.menu_home //To principal button
            ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Clientes()));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      offset: Offset(5, 5)),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              height: 290,
              //width: width - 36,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset("images/cliente.png", width: 100)),
                    //Icon(size: 28.0, FontAwesomeIcons.tooth),
                    const Text(
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        "Cadastre seus clientes e visualize os cadastrados"),
                    const Text(
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        "CLIENTES"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          //PROPAGANDA
          const Admobwidget(),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ConsultarEmitente(),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      offset: Offset(5, 5)),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              height: 260,
              //width: width - 36,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        "images/emitir_nfe.png",
                        width: 70,
                      ),
                    ),
                    //Icon(size: 28.0, FontAwesomeIcons.book),
                    const Text(
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        "Emita sua nota agora mesmo"),
                    const Text(
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        "EMITIR NOTA"),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Admobwidget(),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Valores()));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10.0,
                      color: Color.fromRGBO(0, 0, 0, 0.4),
                      offset: Offset(5, 5)),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              height: 290,
              //width: width - 36,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: Image.asset(
                      "images/servico.png",
                      width: 80,
                    )),

                    //Icon(size: 28.0, FontAwesomeIcons.landmark),
                    const Text(
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        "Cadastre seus serviços"),
                    const Text(
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        "SERVIÇO"),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
