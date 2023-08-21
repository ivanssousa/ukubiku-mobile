import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/pagina_inicial_page.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/pages/sign_up_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icon_right.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AuthController.dart';
import 'package:ukubiku/src/settings/storage/local_storage.dart';
import 'package:ukubiku/src/utils/constantes.dart';
import 'package:ukubiku/src/utils/cores.dart';

class LoginPage extends StatefulWidget
{
  static const routeName = '/login';
  LocalStorage _localStorage = LocalStorage.getInstance();
  late NavigationController navigationController;

  User user = User.novo();
  AuthController authController = new AuthController();


  LoginPage({Key? key, required this.navigationController}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  bool processing = false;

  Widget get topPage => Container(
    margin: EdgeInsets.only(bottom: 50),
    child: Column(
      children: [
        Container(
          child: TituloPrimario("Seja Bem-Vindo n'Ukubiku", fontSize: 20,),
          alignment: Alignment.topLeft,
          margin: EdgeInsets.only(top: 100),
        ),
        Container(
          child: TextoDescricao(
              "Preencha os Campos para acessar a conta",
              TextAlign.left),
          alignment: Alignment.topLeft,
        ),
      ],
    ),
  );

  Widget get camposCredencias => Container(
    child: Column(
      children: [
        Container(
          child: CaixaTexto(
            "Nº de Telefone",
            this.widget.user.username,
            inputType: TextInputType.number,
            getTexto: (String texto) {
              this.widget.user.telefone = texto;
            },
            hintText: "Ex. +244 000000000",
          ),
          alignment: Alignment.topLeft,
        ),
        Container(
          child: CaixaTexto(
            "Palavra-Passe",
            this.widget.user.password,
            isPassword: true,
            getTexto: (String texto) {
              this.widget.user.password = texto;
            },
          ),
          alignment: Alignment.topLeft,
        ),
        Container(
          child: TextoDescricao(
            "Esqueceu a Palavra-Passe?",
            TextAlign.right,
            color: Cores.secundaria(),
            onPress: () {
              print('Esqueci a Palavra-Passe');
            },
          ),
          alignment: Alignment.topRight,
          padding: EdgeInsets.symmetric(vertical: 20),
        ),
      ],
    ),
  );

  Widget get botaoAcessoConta => Container(
    margin: EdgeInsets.only(top: 20),
    child: BotaoIconRight(
      "Acessar Conta",
      this.login,
      this.processing
          ? Container(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      )
          : Container(
        height: 30,
        width: 30,
        child: Icon(
          Icons.login,
          size: 25,
        ),
      ),
      width: 350,
      height: 40,
      background: Cores.primaria(),
    ),
  );

  Widget get botaoCriarConta => Container(
    margin: EdgeInsets.only(top: 20),
    child: BotaoIconRight(
      "Criar Conta",
          () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) => SignUpPage(
                  navigationController:
                  this.widget.navigationController)),
        );
      },
      Container(
        height: 30,
        width: 30,
        child: Icon(
          Icons.app_registration,
          size: 25,
        ),
      ),
      width: 350,
      height: 40,
      background: Cores.secundaria(),
    ),
  );

  @override
  initState() {
    super.initState();
    print(this.widget._localStorage.getToken());
    // this.useToken();

    print( this.widget.user.telefone );
  }

  @override
  void didUpdateWidget(covariant LoginPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    // this.useToken();
    print("assa");
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<void> esperar() async {
    await Future.delayed(Duration(seconds: 2));
  }

  void login() {
    this.setState(() {
      this.processing = true;
    });

    if ( this.widget.user.telefone != null )
      this.widget.user.telefone = this.widget.user.telefone.replaceAll(" ", "");

    this.widget.authController.login(this.widget.user.toMap()).then((RespostaHttp resposta) {
      //
      print(resposta);
      if (resposta.code == Constantes.responseCodes[RespostasHttp.Success]) {
        this._salvarToken(resposta);
      } else {
        if (resposta.message.isEmpty)
          resposta.message = "Não foi possível contactar o servidor";
        this._mostrarMensagemErro(resposta);
      }
    }).catchError((onError) {
      setState(() {
        this.processing = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                this.topPage,
                this.camposCredencias,
                this.botaoAcessoConta,
                this.botaoCriarConta,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _salvarToken(RespostaHttp resposta) {
    this.widget._localStorage.setToken(resposta.data as String).then((value) {
      //
      if (value) {
        print("Chave salva com sucesso");
        this.esperar().then((value) {
          SnackBarSecundaria(resposta.message, () {}, context).show();
          setState(() {
            this.processing = false;
            Navigator.push(context,
                MaterialPageRoute(builder: (builder) => RootUserPage()));
          });
        });
      } else {
        //
      }
    }).catchError((error) {
      //
    });
  }

  void _mostrarMensagemErro(RespostaHttp resposta) {
    this.esperar().then((value) {
      SnackBarErro(resposta.message, () {}, context).show();
      setState(() {
        this.processing = false;
      });
    });
  }

  void useToken() {
    String token = this.widget._localStorage.getToken();

    if (token.isNotEmpty) {
      try {
        this.widget.authController.user().then((value) {
          this
              .widget
              .navigationController
              .toBottomMenu(context, RootUserPage.routeName);
        }).catchError((erro) {
          print(erro);
        });
      } catch (ex) {
        print(ex);
      }
    }
  }
}
