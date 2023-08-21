import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/login_page.dart';
import 'package:ukubiku/src/apresentacao/pages/perfil_cliente_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icon_right.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/modals/modal_verificar_codigo.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AuthController.dart';
import 'package:ukubiku/src/utils/cores.dart';

class SignUpPage extends StatefulWidget {
  static const routeName = '/sign_up';

  AuthController authController = new AuthController();
  late NavigationController navigationController;

  String _nomeCompleto = '';
  String _email = '';
  String _nomeUsuario = '';
  String _telefone = '';
  String _palavraPasse = '';

  SignUpPage({Key? key, required this.navigationController}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  Pessoa _pessoa = Pessoa.nova();
  User _user = User.novo();
  Contacto _contacto = Contacto.novo();

  bool processing = false;

  Future<void> esperar() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void cadastrar() {
    Map<String, dynamic> parametros = HashMap();
    parametros.putIfAbsent("nomeCompleto", () => this._pessoa.nome);
    parametros.putIfAbsent("nomeUsuario", () => this._user.username);
    parametros.putIfAbsent("email", () => this._user.email);
    parametros.putIfAbsent(
        "telefone", () => this._contacto.contacto.replaceAll(" ", ""));
    parametros.putIfAbsent("password", () => this._user.password);

    this.setState(() {
      this.processing = true;
    });

    this.widget.authController.cadastrar(parametros).then((RespostaHttp value) {
      //
      var _message = value.message;
      this.esperar().then((value) => {
            this.setState(() {
              this.processing = false;
              SnackBarSecundaria(_message, () {}, context).show();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (builder) => LoginPage(
                          navigationController:
                              this.widget.navigationController)));
            })
          });
    }).catchError((onError) => {print(onError)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 50),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Column(
                    children: [
                      Container(
                        child: BotaoBack(BotaoModel('Acessar Conta', () {
                          Navigator.pop(context);
                        })),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 50),
                      ),
                      Container(
                        child: TituloPrimario("Criar Conta"),
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(top: 0),
                      ),
                      Container(
                        child: TextoDescricao(
                            "Faça Parte da Nossa Plataforma", TextAlign.left),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: CaixaTexto(
                          "Nome Completo",
                          this.widget._nomeCompleto,
                          inputType: TextInputType.emailAddress,
                          getTexto: (String texto) {
                            this.widget._nomeCompleto = texto;
                            this._pessoa.nome = texto;
                          },
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: CaixaTexto(
                          "E-mail",
                          this.widget._email,
                          inputType: TextInputType.emailAddress,
                          getTexto: (String texto) {
                            this.widget._email = texto;
                            this._user.email = texto;
                          },
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: CaixaTexto(
                          "Nome de Usuário",
                          this.widget._nomeUsuario,
                          getTexto: (String texto) {
                            this.widget._nomeUsuario = texto;
                            this._user.username = texto;
                          },
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: CaixaTexto(
                          "Nº de Telefone",
                          this.widget._telefone,
                          getTexto: (String texto) {
                            this.widget._telefone = texto;
                            this._contacto.contacto = texto;
                          },
                          inputType: TextInputType.phone,
                          hintText: "Ex. +244 000000000",
                        ),
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        child: CaixaTexto(
                          "Palavra-Passe",
                          this.widget._palavraPasse,
                          isPassword: true,
                          getTexto: (String texto) {
                            this.widget._palavraPasse = texto;
                            this._user.password = texto;
                          },
                        ),
                        alignment: Alignment.topLeft,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: BotaoIconRight(
                    "Cadastrar",
                    this.cadastrar,
                    this.processing
                        ? Container(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Icon(
                            Icons.check,
                            size: 30,
                          ),
                    width: 350,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
