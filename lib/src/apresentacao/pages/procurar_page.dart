import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icon_right.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';

class ProcurarPagina extends StatefulWidget {
  static const routeName = '/filtrar_page';
  bool processing = true;

  ProcurarPagina(this.processing, {Key? key}) : super(key: key);

  @override
  _ProcurarPaginaState createState() => _ProcurarPaginaState();
}

class _ProcurarPaginaState extends State<ProcurarPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(left: 20, right: 20, top: 0),
          child: Container(
            margin: EdgeInsets.only(top: 10),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          Container(
                            child: BotaoBack(
                              BotaoModel(
                                'Voltar',
                                    () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: CaixaTexto(
                              "Cidade, Localidade",
                              "",
                              prefixIcon:
                              Icon(Icons.airplanemode_active_outlined),
                              sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
                              inputType: TextInputType.emailAddress,
                              enabled: false,
                              getTexto: (String texto) {
                                print(texto);
                              },
                            ),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 10),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: CaixaTexto(
                                      "Preço Min.",
                                      "",
                                      inputType:
                                      TextInputType.numberWithOptions(
                                          decimal: true),
                                      prefixIcon:
                                      Icon(Icons.attach_money_outlined),
                                      getTexto: (String texto) {},
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: CaixaTexto(
                                      "Preço Máx.",
                                      "",
                                      inputType:
                                      TextInputType.numberWithOptions(
                                          decimal: true),
                                      prefixIcon:
                                      Icon(Icons.attach_money_outlined),
                                      getTexto: (String texto) {
                                        //
                                      },
                                    ),
                                    alignment: Alignment.topLeft,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: CaixaTexto(
                              "Categoria",
                              "",
                              prefixIcon: Icon(Icons.bed_outlined),
                              sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
                              inputType: TextInputType.emailAddress,
                              getTexto: (String texto) {},
                            ),
                            alignment: Alignment.topLeft,
                          ),
                          Container(
                            child: CaixaTexto(
                              "Tipologia",
                              "",
                              prefixIcon: Icon(Icons.bed_outlined),
                              sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
                              inputType: TextInputType.emailAddress,
                              getTexto: (String texto) {},
                            ),
                            alignment: Alignment.topLeft,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, bottom: 50),
                      child: BotaoIconRight(
                        "Procurar Moradia",
                        () {
                        },
                        this.widget.processing
                            ? Container(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                            : Icon(
                          Icons.search_sharp,
                          size: 35,
                        ),
                        width: 350,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
