import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/alugado/index.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/BarCodeManager.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ComprovativoPage extends StatefulWidget {
  Aluguer _aluguer;
  late NavigationController navigation;

  ComprovativoPage(this._aluguer, {Key? key, required this.navigation}) {}

  @override
  _ComprovativoPageState createState() => _ComprovativoPageState();
}

class _ComprovativoPageState extends State<ComprovativoPage> {
  List<String> metodosPagamentos = [
    "Pagamento a Cash",
    "Transferência Bancária",
    "Pagamento por Referência",
    "Cartão de Débito"
  ];

  double fontSize = 14;
  final AssetImage assetLogotipo = AssetImage("assets/images/logo.png");

  late BarCodeManager barCodeManager;

  late File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.barCodeManager =
        BarCodeManager(data: this.widget._aluguer.id.toString());
    this.barCodeManager.gerarBarCode().then((file) {
      setState(() {
        // this.file = File( file );
        // print( file );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.primaria(),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 50,
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    this.botaoVoltar(),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Stack(
                                children: [
                                  Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(0),
                                      child: Image(
                                        image: this.assetLogotipo,
                                        width: 60,
                                        height: 90,
                                      )),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(top: 70),
                                    padding: EdgeInsets.all(0),
                                    child: TituloPrimario(
                                      "Comprovativo",
                                      fontSize: 18,
                                      textAlign: TextAlign.center,
                                      margin: EdgeInsets.only(top: 10),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 110),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    this
                                                        .widget
                                                        ._aluguer
                                                        .imovel
                                                        .opTipoImovelId
                                                        .descricao
                                                        .toUpperCase(),
                                                    TextAlign.left,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    this
                                                        .widget
                                                        ._aluguer
                                                        .imovel
                                                        .titulo,
                                                    TextAlign.left,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Sócio",
                                                    TextAlign.left,
                                                    fontSize: this.fontSize,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, left: 10),
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: TituloPrimario(
                                                    this
                                                        .widget
                                                        ._aluguer
                                                        .cliente
                                                        .rhPessoaId
                                                        .nome
                                                        .toString(),
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    color: Cores.secundaria(),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: this.fontSize,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Data Entrada",
                                                    TextAlign.left,
                                                    fontSize: this.fontSize,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, left: 10),
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: TituloPrimario(
                                                    this
                                                        .widget
                                                        ._aluguer
                                                        .getHorarioInicial,
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    color: Cores.secundaria(),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: this.fontSize,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Data de Saída",
                                                    TextAlign.left,
                                                    fontSize: this.fontSize,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, left: 10),
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: TituloPrimario(
                                                    this
                                                        .widget
                                                        ._aluguer
                                                        .getHorarioFinal,
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    color: Cores.secundaria(),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: this.fontSize,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Tempo de Estadia",
                                                    TextAlign.left,
                                                    fontSize: this.fontSize,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, left: 10),
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: TituloPrimario(
                                                    this
                                                            .widget
                                                            ._aluguer
                                                            .totalDiasEstadia
                                                            .toString() +
                                                        " dia(s)",
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    color: Cores.secundaria(),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: this.fontSize,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Agente",
                                                    TextAlign.left,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child: TextoDescricao(
                                                    "Cinapse SA",
                                                    TextAlign.right,
                                                    fontSize: this.fontSize,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Data de Marcação",
                                                    TextAlign.left,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  child: TextoDescricao(
                                                    this._dataActual(),
                                                    TextAlign.right,
                                                    fontSize: this.fontSize,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Estado do Pedido",
                                                    TextAlign.left,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  child: TextoDescricao(
                                                    this.getEstadoLabel(),
                                                    TextAlign.right,
                                                    fontSize: this.fontSize,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                  ),
                                                  padding: EdgeInsets.all(0),
                                                  child: TextoDescricao(
                                                    "Custo Total",
                                                    TextAlign.left,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Cores.secundaria(),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    top: 0,
                                                    left: 10,
                                                  ),
                                                  padding: EdgeInsets.only(
                                                    right: 10,
                                                  ),
                                                  child: TituloPrimario(
                                                    this
                                                            .widget
                                                            ._aluguer
                                                            .custoTotal
                                                            .toString() +
                                                        ' Kz',
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    color: Cores.secundaria(),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18,
                                                    textAlign: TextAlign.right,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Divider(
                                            color: Cores.secundaria(),
                                            thickness: 1,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 0),
                                          child: Image(
                                            image: assetLogotipo,
                                            height: 50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: (MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height * 0.23)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: BotaoIcone(
                          iconData: Icons.check,
                          background: Cores.secundaria(),
                          onPress: () {
                            this._navigateTo(AlugadoPage.routeName);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: BotaoIcone(
                          iconData: Icons.share_outlined,
                          background: Cores.secundaria(),
                          onPress: () {
                            //
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: BotaoIcone(
                          iconData: Icons.home_outlined,
                          background: Cores.secundaria(),
                          onPress: () {
                            //
                            this._navigateTo(RootUserPage.routeName);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: BotaoIcone(
                          iconData: Icons.map_outlined,
                          background: Cores.secundaria(),
                          onPress: () {
                            //
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _dataActual() {
    DateTime data = DateTime.now();
    return data.day.toString() +
        "-" +
        data.month.toString() +
        "-" +
        data.year.toString();
  }

  dynamic _navigateTo(String page) {
    this.widget.navigation.toBottomMenu(context, page);
    // return Navigator.push(
    //     context, MaterialPageRoute(builder: (builder) => page));
  }

  botaoVoltar() {
    return Container(
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
              cor: Cores.branco(),
            ),
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 0),
          ),
        ],
      ),
    );
  }

  String getEstadoLabel() {
    if (this.widget._aluguer.estadoAluguerId != null)
      return this.widget._aluguer.estadoAluguerId.descricao;
    return "Não definido.";
  }
}
