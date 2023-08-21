import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/data_widget.dart';
import 'package:ukubiku/src/apresentacao/widgets/imagem_perfil.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AuthController.dart';

import '../widgets/botao_back.dart';
import '../widgets/caixa_texto.dart';
import '../widgets/models/BotaoModel.dart';
import '../widgets/primary_button.dart';
import '../widgets/titulo_primary.dart';

class PerfilClientePage extends StatefulWidget {
  static const routeName = '/perfil_cliente';

  const PerfilClientePage({Key? key}) : super(key: key);

  @override
  _PerfilClientePageState createState() => _PerfilClientePageState();
}

class _PerfilClientePageState extends State<PerfilClientePage> {
  late AuthController authController;
  User? user;

  TextEditingController _nomeController = TextEditingController(text: "");
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _usernameController = TextEditingController(text: "");
  TextEditingController _telefoneController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.authController = AuthController();
    this.authController.user().then((User value) {
      this.user = value;
      print(value.toMap());
      // print( value.email );
      this._nomeController.text = value.rh_pessoa_id.nome;
      this._emailController.text = value.email;
      this._usernameController.text = value.username;
      this._telefoneController.text = value.telefone;
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Column(
                      children: [
                        this._botaoVoltarWidget(),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ImagemPerfil(
                              width: 200,
                              height: 200,
                              onTap: () {},
                            ),
                            Positioned(
                              left: 120,
                              top: 130,
                              child: Container(
                                child: BotaoIcone(
                                  iconData: Icons.photo_camera_outlined,
                                  onPress: () {},
                                  sizeIcon: 40,
                                  radius: 50,
                                ),
                                alignment: Alignment.center,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          child: CaixaTexto(
                            "Nome Completo",
                            "",
                            controller: this._nomeController,
                            inputType: TextInputType.emailAddress,
                            getTexto: (String texto) {},
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: CaixaTexto(
                            "Gênero",
                            "",
                            inputType: TextInputType.emailAddress,
                            getTexto: (String texto) {},
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: DataWidget('Data de Nascimento'),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: CaixaTexto(
                            "E-mail",
                            "",
                            controller: this._emailController,
                            inputType: TextInputType.emailAddress,
                            getTexto: (String texto) {},
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: CaixaTexto(
                            "Nome de Usuário",
                            "",
                            controller: this._usernameController,
                            getTexto: (String texto) {},
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: CaixaTexto(
                            "Nº de Telefone",
                            this.user?.telefone != null ? this.user?.telefone as String : "Não Identificado.",
                            controller: this._telefoneController,
                            getTexto: (String texto) {},
                            inputType: TextInputType.number,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          child: CaixaTexto(
                            "Palavra-Passe",
                            "",
                            isPassword: true,
                            getTexto: (String texto) {},
                          ),
                          alignment: Alignment.topLeft,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 50),
                    child: PrimaryButton(
                      "Salvar Informações",
                      () {},
                      width: 350,
                    ),
                  ),
                ],
              ))),
    ));
  }

  Widget _botaoVoltarWidget() {
    return Container(
      child: BotaoBack(BotaoModel('Voltar', () {
        Navigator.pop(context);
      })),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 20),
    );
  }
}
