import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/grelha_galeria.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/domain/controllers/ContactoController.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ContactoPage extends StatefulWidget
{
  late Function _onSave;
  late ContactoController contactoController;

  ContactoPage( Function onSave, {ContactoController? controller})
  {
    this._onSave = onSave != null ? onSave : (){};

    if ( controller != null )
      this.contactoController = controller;
  }

  @override
  _ContactoPageState createState() => _ContactoPageState();
}

class _ContactoPageState extends State<ContactoPage>
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Container(
                child: Stack(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: Cores.primaria(),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            height: 300,
                            alignment: Alignment.topLeft,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: BotaoBack(
                        BotaoModel(
                          'Voltar',
                          () {
                            Navigator.pop(context);
                          },
                        ),
                        cor: Cores.branco(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 70,
                        horizontal: 20,
                      ),
                      child: TituloPrimario(
                        "Dados de Contacto",
                        color: Cores.branco(),
                        fontSize: 20,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                            left: 20,
                            right: 20,
                            top: 150,
                          ),
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 40,
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                          ),
                                          child: CaixaTexto(
                                            "Telefone",
                                            "",
                                            enabled: false,
                                            readOnly: false,
                                            textAlign: TextAlign.right,
                                            prefixIcon: Icon(Icons.phone),
                                            getTexto: (String value) {
                                              print(value);
                                            },
                                          ),
                                          alignment: Alignment.topLeft,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 0,
                                      ),
                                      child: CaixaTexto(
                                        "E-mail",
                                        "",
                                        enabled: false,
                                        readOnly: false,
                                        prefixIcon:
                                            Icon(Icons.mail_outline_rounded),
                                        getTexto: (String value) {
                                          print(value);
                                        },
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 20),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: PrimaryButton(
                                        "Salvar",
                                        () {
                                          this.widget._onSave();
                                        },
                                        width: double.infinity,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 40,
                              ),
                              child: Icon(
                                Icons.arrow_circle_down_sharp,
                                color: Colors.black26,
                                size: 40,
                              )),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 40,
                            ),
                            child: TextoDescricao(
                              "Iremos enviar a confirmação para o contacto fornecido acima, este será utilizado também para conbranças.",
                              TextAlign.center,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
