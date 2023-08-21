import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/index.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/card_agencia_turismo.dart';
import 'package:ukubiku/src/apresentacao/widgets/comentario_container.dart';
import 'package:ukubiku/src/apresentacao/widgets/grelha_galeria.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/GaleriaController.dart';
import 'package:ukubiku/src/domain/controllers/ImovelController.dart';
import 'package:ukubiku/src/utils/cores.dart';

import '../../data/models/RespostaHttp.dart';

class ItemSelecionadoPage extends StatefulWidget {
  Imovel _imovel;
  GaleriaController galeriaController = GaleriaController();

  ItemSelecionadoPage(this._imovel) {}

  @override
  _ItemSelecionadoPageState createState() => _ItemSelecionadoPageState();
}

class _ItemSelecionadoPageState extends State<ItemSelecionadoPage>
//
{
  late ImovelController imovelController;

  Aluguer _aluguer = Aluguer.nova();
  Proprietario proprietario = Proprietario.nova();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<Galeria> galeria = List.empty(growable: true);

  @override
  initState() {
    super.initState();

    this.imovelController = ImovelController(context: this.context);

    this.getProprietario();
    this.loadGaleria();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  void didUpdateWidget(covariant ItemSelecionadoPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Widget Lifecycle: didUpdateWidget');

    // this.getProprietario();
    // this.loadGaleria();
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
              children: [
                Column(
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
                          Column(
                            children: [
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      child: TituloPrimario(
                                        this.widget._imovel.titulo,
                                        fontSize: 20,
                                        color: Cores.secundaria(),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(bottom: 10, left: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Cores.laranja(),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Cores.laranja(),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Cores.laranja(),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Cores.laranja(),
                                          ),
                                          Icon(
                                            Icons.star,
                                            size: 15,
                                            color: Cores.laranja(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(top: 0),
                              ),
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: BotaoIcone(
                                        iconData: Icons.event_outlined,
                                        background: Cores.primaria(),
                                        onPress: () {},
                                        radius: 15,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: BotaoIcone(
                                        iconData: Icons.apartment_outlined,
                                        background: Cores.primaria(),
                                        onPress: () {
                                          print('');
                                        },
                                        radius: 15,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: BotaoIcone(
                                        iconData: Icons.attach_money_outlined,
                                        background: Cores.primaria(),
                                        onPress: () {
                                          print('');
                                        },
                                        radius: 15,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      child: BotaoIcone(
                                        iconData: Icons.people_outline,
                                        background: Cores.primaria(),
                                        onPress: () {
                                          print('');
                                        },
                                        radius: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                      vertical: 0,
                                      horizontal: 10,
                                    ),
                                    child: TituloPrimario(
                                      "Período Aluguer",
                                      fontSize: 18,
                                      color: Cores.secundaria(),
                                      margin: EdgeInsets.symmetric(
                                        vertical: 5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: TableCalendar(
                                      firstDay: DateTime.utc(
                                          DateTime.now().year,
                                          DateTime.now().month,
                                          DateTime.now().day),
                                      lastDay: DateTime.utc(
                                          DateTime.now().year + 10, 12, 31),
                                      focusedDay: _focusedDay,
                                      selectedDayPredicate: (day) =>
                                          isSameDay(_selectedDay, day),
                                      rangeStartDay: _rangeStart,
                                      rangeEndDay: _rangeEnd,
                                      calendarFormat: _calendarFormat,
                                      rangeSelectionMode: _rangeSelectionMode,
                                      onDaySelected: (selectedDay, focusedDay) {
                                        if (!isSameDay(
                                            _selectedDay, selectedDay)) {
                                          setState(() {
                                            _selectedDay = selectedDay;
                                            _focusedDay = focusedDay;
                                            _rangeStart =
                                                null; // Important to clean those
                                            _rangeEnd = null;
                                            _rangeSelectionMode =
                                                RangeSelectionMode.toggledOff;
                                          });
                                        }
                                      },
                                      onRangeSelected:
                                          (start, end, focusedDay) {
                                        setState(() {
                                          _selectedDay = null;
                                          _focusedDay = focusedDay;
                                          _rangeStart = start;
                                          _rangeEnd = end;

                                          this._aluguer.horarioInicial =
                                              start != null
                                                  ? start
                                                  : DateTime.now();
                                          this._aluguer.horarioFinal =
                                              end != null
                                                  ? end
                                                  : DateTime.now();
                                          this._aluguer.imovel =
                                              this.widget._imovel;

                                          print(this._aluguer.horarioInicial);
                                          _rangeSelectionMode =
                                              RangeSelectionMode.toggledOn;
                                        });
                                      },
                                      onFormatChanged: (format) {
                                        if (_calendarFormat != format) {
                                          setState(() {
                                            _calendarFormat = format;
                                          });
                                        }
                                      },
                                      onPageChanged: (focusedDay) {
                                        _focusedDay = focusedDay;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 10,
                                  ),
                                  child: TituloPrimario(
                                    "Descrição",
                                    fontSize: 18,
                                    color: Cores.secundaria(),
                                    margin: EdgeInsets.symmetric(vertical: 15),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      right: 10, left: 10, bottom: 10),
                                  child: TextoDescricao(
                                    this.widget._imovel.descricao,
                                    TextAlign.left,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                            ),
                            child: CardAgenciaTurismo(
                                proprietario: this.proprietario),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin:
                                EdgeInsets.only(top: 0, bottom: 10, left: 10),
                            child: GrelhaGaleria(this.galeria),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: ComentarioContainer(),
                          )
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
                      this.widget._imovel.custo.toString(),
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
              child: BotaoIcone(
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
                "Alugar",
                () {
                  //
                  if (this._rangeStart == null) {
                    SnackBarErro("Data Inicial não Selecionada", () {}, context)
                        .show();
                    return;
                  } else if (this._rangeEnd == null) {
                    SnackBarErro("Data Final não Selecionada", () {}, context)
                        .show();
                    return;
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => AluguerPage(this._aluguer,
                            navigationController:
                                NavigationController.getInstance()),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        )
      ],
    );
  }

  void getProprietario() {
    print("Proprietario: " + this.widget._imovel.id.toString());
    this.imovelController.getById(this.widget._imovel.id).then((value) {
      dynamic data = value.data;
      setState(() {
        // this.widget._aluguer.imovel = this.widget._imovel;
        this.proprietario = Proprietario.fromData(data['proprietario']);
        Pessoa pessoa = Pessoa.fromJson(data['proprietario']['rhPessoaId']);
        this.proprietario.rhPessoaId = pessoa;
      });
    }).catchError((error) {
      print('Item Selecionado Error');
      //
    });
  }

  void loadGaleria() {
    print("Load Galeria: " + this.widget._imovel.id.toString());
    this
        .widget
        .galeriaController
        .getByImovel(this.widget._imovel.id)
        .then((RespostaHttp resposta) {
      // print("Load Galeria");
      print(resposta.data);
      List<Galeria> items = Galeria.fromJsonList(resposta.data);
      this.setState(() {
        this.galeria = items;
      });
    }).catchError((error) {
      // print("Load Galeria");
      print(error);
    });
  }
}
