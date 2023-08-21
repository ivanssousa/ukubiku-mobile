import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/data_widget.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';

import '../pages/root_user_page.dart';
import 'botao_back.dart';
import 'imagem_perfil.dart';
import 'models/BotaoModel.dart';


class DialogoFiltrar extends StatefulWidget {
  const DialogoFiltrar({Key? key}) : super(key: key);

  @override
  _DialogoFiltrarState createState() => _DialogoFiltrarState();
}

class _DialogoFiltrarState extends State<DialogoFiltrar> {
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
                            Container(
                              child: BotaoBack(BotaoModel('Página Inicial', () {
                                Navigator.restorablePushNamed(
                                    context, RootUserPage.routeName);
                              })),
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 20),
                            ),
                            Container(
                              child: TituloPrimario(
                                "Perfil",
                                fontSize: 18,
                                margin: EdgeInsets.only(bottom: 20, top: 5),
                              ),
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 0),
                            ),
                            ImagemPerfil(
                              width: 100,
                              height: 100,
                              onTap: () {},
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
                              child: DataWidget('Selecionar Data'),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              child: CaixaTexto(
                                "E-mail",
                                "",
                                inputType: TextInputType.emailAddress,
                                getTexto: (String texto) {},
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              child: CaixaTexto(
                                "Nome de Usuário",
                                "",
                                getTexto: (String texto) {},
                              ),
                              alignment: Alignment.topLeft,
                            ),
                            Container(
                              child: CaixaTexto(
                                "Nº de Telefone",
                                "",
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
}

