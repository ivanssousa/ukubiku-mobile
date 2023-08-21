import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/comprovativo_page.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/contacto_page.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/hospedes_page.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/metodo_pagamento_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_opcao_aluguer.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AluguerController.dart';
import 'package:ukubiku/src/domain/controllers/ContactoController.dart';
import 'package:ukubiku/src/utils/cores.dart';

import '../../widgets/item_opcao_card.dart';

class AluguerPage extends StatefulWidget {
  Imovel _imovel = Imovel.empty();
  Aluguer _aluguer = Aluguer.nova();
  NavigationController navigationController;

  ContactoController contactoController = ContactoController();

  AluguerPage(Aluguer aluguer, {required this.navigationController}) {
    this._aluguer = aluguer;
    this._imovel = aluguer.imovel;
  }

  @override
  _AluguerPageState createState() => _AluguerPageState();
}

class _AluguerPageState extends State<AluguerPage> {
  late AluguerController aluguerController =
      AluguerController(context: this.context);

  bool loading = false;

  List<Contacto> contactos = List.empty(growable: true);
  List<Widget> contactosWidget = List.empty(growable: true);

  List<Hospede> hospedes = List.empty(growable: true);
  List<Widget> hospedesWidget = List.empty(growable: true);

  @override
  initState() {
    super.initState();

    this.addHospedeToWidget();
  }

  @override
  void didChangeDependencies() {
    print('Widget Lifecycle: didChangeDependencies');
    super.didChangeDependencies();

    this._initContactos();
  }

  @override
  void didUpdateWidget(covariant AluguerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Widget Lifecycle: didUpdateWidget');

    // print(this.widget._imovel.opTipoImovelId.descricao);
    this.contactosWidget = this.buildContactos();
  }

  @override
  void deactivate() {
    print('Widget Lifecycle: deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('Widget Lifecycle: dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 50,
          ),
          child: Container(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
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
                            margin: EdgeInsets.only(top: 0),
                          ),
                          Card(
                            child: Column(
                              children: [
                                Container(
                                    child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image(
                                    image: AssetImage(
                                      "assets/images/item_publicacao.jpeg",
                                    ),
                                    alignment: Alignment(0, 0),
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                )),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: TituloPrimario(
                                    this.widget._imovel.titulo,
                                    fontSize: 17,
                                    margin:
                                        EdgeInsets.only(top: 15, bottom: 10),
                                    color: Cores.secundaria(),
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.event_outlined,
                                            size: 15,
                                            color: Cores.secundaria(),
                                          ),
                                          TituloPrimario(
                                            this
                                                    .widget
                                                    ._imovel
                                                    .getDataInicio() +
                                                " - " +
                                                this
                                                    .widget
                                                    ._imovel
                                                    .getDataFinal(),
                                            color: Cores.secundaria(),
                                            fontSize: 13,
                                            margin: EdgeInsets.only(left: 5),
                                            fontWeight: FontWeight.w600,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Divider(
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  alignment: Alignment.centerLeft,
                                  child: TituloPrimario(
                                    "Detalhes de Aluguer",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    margin: EdgeInsets.only(bottom: 10, top: 5),
                                    color: Cores.secundaria(),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: RotationTransition(
                                                      child: Icon(
                                                        Icons
                                                            .airplanemode_active_outlined,
                                                        color:
                                                            Cores.secundaria(),
                                                      ),
                                                      turns:
                                                          AlwaysStoppedAnimation(
                                                              40 / 360),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                        this._totalDiasStr()),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 30),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.apartment_rounded,
                                                      color: Cores.secundaria(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text('Soyo/Zaire'),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        child: Stack(
                                          children: [
                                            Container(
                                              child: Row(
                                                children: [
                                                  Container(
                                                    child: Icon(
                                                      Icons.bed_outlined,
                                                      color: Cores.secundaria(),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(this
                                                        .widget
                                                        ._imovel
                                                        .opTipoImovelId
                                                        .descricao),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 30),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Icon(
                                                        Icons.people_outline,
                                                        color:
                                                            Cores.secundaria(),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(this
                                                              .hospedes
                                                              .toSet()
                                                              .length
                                                              .toString() +
                                                          ' Hospedes'),
                                                    ),
                                                  ],
                                                ))
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
                            alignment: Alignment.centerLeft,
                            child: TituloPrimario(
                              "Detalhes de Contacto",
                              color: Cores.secundaria(),
                              fontSize: 17,
                              margin: EdgeInsets.only(
                                left: 10,
                                top: 15,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Column(
                                children: this.contactosWidget,
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TituloPrimario(
                              "Detalhes dos Hospedes",
                              color: Cores.secundaria(),
                              fontSize: 17,
                              margin: EdgeInsets.only(
                                left: 10,
                                top: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: this.hospedesWidget,
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TituloPrimario(
                              "Metódo de Pagamento",
                              color: Cores.secundaria(),
                              fontSize: 17,
                              margin: EdgeInsets.only(
                                left: 10,
                                top: 15,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ItemOpcaoAluguer(
                                    "Selecionar Metódo",
                                    Icon(Icons.attach_money_outlined),
                                    Icon(Icons.arrow_forward_ios),
                                    press: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (builder) =>
                                                MetodoPagamentoPage()),
                                      );
                                    },
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
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextoDescricao(
                      "Custo Total",
                      TextAlign.start,
                      margin: EdgeInsets.only(
                        top: 10,
                      ),
                    ),
                    TituloPrimario(
                      (this.widget._imovel.custo *
                                  (double.parse(this._totalDias().toString())))
                              .toString() +
                          " Kz",
                      fontSize: 14,
                      color: Cores.secundaria(),
                      margin: EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                right: 5,
              ),
              child: this.loading
                  ? this.showLoading()
                  : BotaoIcone(
                      iconData: Icons.favorite_outline,
                      background: Cores.primaria(),
                      radius: 50,
                      sizeIcon: 22,
                      onPress: () {
                        //
                      },
                    ),
            ),
            Expanded(
              child: PrimaryButton(
                "Confirmar",
                () {
                  print(this.widget._aluguer.toJson());

                  this.solicitarAluguer();
                },
              ),
            )
          ],
        )
      ],
    );
  }

  int _totalDias() {
    DateTime horarioInicial = this.widget._aluguer.horarioInicial;
    DateTime horarioFinal = this.widget._aluguer.horarioFinal;

    return horarioFinal.difference(horarioInicial).inDays;
  }

  String _totalDiasStr() {
    return this._totalDias().toString() + " Dias";
  }

  void _initContactos() {
    this
        .widget
        .contactoController
        .meus()
        .then(this.lerContactos)
        .catchError(this.lerErro);
  }

  void lerContactos(RespostaHttp resposta) {
    print("Contactos");
    print(resposta);

    if (resposta.code == HttpStatus.ok) {
      this.contactos = Contacto.fromJsonList(resposta.data);
      setState(() {
        this.contactosWidget = this.buildContactos();
      });
    } else {
      print(resposta.message.toString());
      SnackBarErro(resposta.message.toString(), () {}, context).show();
    }
  }

  void lerErro(erro) {
    print(erro);
    SnackBarErro(erro.toString(), () {}, this.context).show();
  }

  List<Widget> buildContactos() {
    List<Widget> temp = List.empty(growable: true);
    for (Contacto contacto in this.contactos) {
      temp.add(ItemOpcaoCard(
          contacto.contacto,
          Icon(
              contacto.tipo == 'telefone' ? Icons.phone : Icons.email_outlined),
          Icon(Icons.check),
          press: () {}));
    }

    temp.add(ItemOpcaoCard(
      "Adicionar Contacto",
      Icon(Icons.phone),
      Icon(Icons.add),
      press: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (builder) => ContactoPage(
              () {
                Navigator.pop(context);
              },
              controller: this.widget.contactoController,
            ),
          ),
        );
      },
    ));
    return temp;
  }

  bool _hospedeInLista(Hospede hospede) {
    return this
        .hospedes
        .where((element) => element.identificacao == hospede.identificacao)
        .isNotEmpty;
  }

  Future<void> addHospede(Hospede hospede) async {
    this.hospedes.add(hospede);
    SnackBarSecundaria("Hospede adicionado com sucesso,", () {}, context)
        .show();
    this.addHospedeToWidget();
    Future.delayed(const Duration(seconds: 2));
  }

  void addHospedeToWidget() {
    this.hospedesWidget = List.empty(growable: true);
    List<Widget> temp = List.empty(growable: true);

    for (Hospede item in this.hospedes) {
      temp.add(Container(
        margin: EdgeInsets.only(top: 0),
        child: ItemOpcaoCard(
          item.nome,
          Icon(Icons.person_outline),
          Icon(Icons.check),
          press: () {},
        ),
      ));
    }

    temp.add(Container(
      margin: EdgeInsets.only(top: 0),
      child: ItemOpcaoCard(
        "Adicionar Hospede",
        Icon(Icons.person_outline),
        Icon(Icons.add),
        press: () {
          Navigator.push(context, MaterialPageRoute(builder: (builder) {
            return HospedePage(
              onSave: (Hospede hospede) {
                print(hospede);
                if (!this._hospedeInLista(hospede)) {
                  this
                      .addHospede(hospede)
                      .then((value) => {Navigator.pop(context)})
                      .catchError((onError) => {});
                }
              },
            );
          }));
        },
      ),
    ));

    setState(() {
      this.hospedesWidget = temp;
      this.widget._aluguer.hospedes = this.hospedes;
    });
  }

  void solicitarAluguer() {
    this.setLoading(true);

    this
        .aluguerController
        .salvar(this.widget._aluguer)
        .then((RespostaHttp value) {
      this.setLoading(false);

      print(value);
      if (value.code == HttpStatus.ok || value.code == HttpStatus.created) {
        Aluguer aluguer = Aluguer.fromJson(value.data);
        SnackBarPrimaria(
                message: value.message, onPress: () {}, context: this.context)
            .show();

        Future.delayed(Duration(seconds: 3)).then((value) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => ComprovativoPage(
                aluguer,
                navigation: this.widget.navigationController,
              ),
            ),
          );
        });
      } else {
        SnackBarAlerta(
          message: value.message,
          onPress: () {},
          context: this.context,
        ).show();
      }
    }).catchError((erro) {
      this.setLoading(false);
      print(erro);
      SnackBarErro("Não foi possível solicitar o Imovel.", () {}, this.context)
          .show();
    });
  }

  void setLoading(bool state) {
    setState(() {
      this.loading = state;
    });
  }

  Widget showLoading() {
    return Container(
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            color: Cores.primaria(),
            child: Container(
              padding: EdgeInsets.all(7.5),
              child: CircularProgressIndicator(
                color: Cores.branco(),
              ),
            )));
  }
}
