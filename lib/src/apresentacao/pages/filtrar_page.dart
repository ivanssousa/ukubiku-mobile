import 'package:flutter/material.dart';
import 'dart:io';
import 'package:ukubiku/src/apresentacao/pages/resultado_procura_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icon_right.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/data/pagina_filtrar_data.dart';
import 'package:ukubiku/src/apresentacao/widgets/modals/modal_cidade.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/TipoImovelController.dart';
import 'package:ukubiku/src/domain/controllers/CidadeController.dart';
import 'package:ukubiku/src/domain/controllers/TipologiaController.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ukubiku/src/utils/cores.dart';
import '../widgets/titulo_primary.dart';

class FiltrarPage extends StatefulWidget {
  static const routeName = '/filtrar_page';
  String dropdownValue = 'One';
  late PaginaFiltrarData data;

  NavigationController navigationController;

  FiltrarPage(
      {Key? key, PaginaFiltrarData? data, required this.navigationController}) {
    if (data != null)
      this.data = data;
    else
      this.data = PaginaFiltrarData();
    print(data?.tipoImovel.descricao);
  }

  @override
  _FiltrarPageState createState() => _FiltrarPageState();
}

class _FiltrarPageState extends State<FiltrarPage> {
  bool processing = false;

  late TipologiaController _tipologiaController;
  late CidadeController _cidadeController;
  late TipoImovelController _tipoImovelController;

  late List<Tipologia> _tipologias;
  late List<Cidade> _cidades;
  late List<TipoImovel> _tipoImoveis;

  Cidade _cidade = Cidade.novo();
  Tipologia _tipologia = Tipologia.novo();

  late PaginaFiltrarData filtering;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  TextEditingController _textCidadeController = TextEditingController(text: "");
  TextEditingController _textTipologiaController =
      TextEditingController(text: "");
  TextEditingController _textTipoImovelController =
      TextEditingController(text: "");
  TextEditingController _textPrecoMinController =
      TextEditingController(text: "0");
  TextEditingController _textPrecoMaxController =
      TextEditingController(text: "0");

  Future<void> esperar() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._tipologias = List.empty(growable: true);
    this._cidades = List.empty(growable: true);
    this._tipoImoveis = List.empty(growable: true);

    this._listarTipologias().then((value) => {}).catchError((error) => {});
    this._listarCidades().then((value) => {}).catchError((error) => {});
    this._listarTipoImoveis().then((value) => {}).catchError((error) => {});

    if (this.widget.data != null) {
      this.filtering = this.widget.data;
      if (this.widget.data.tipoImovel != null)
        _textTipoImovelController.text = this.filtering.tipoImovel.descricao;
    } else
      this.filtering = PaginaFiltrarData();
  }

  Future<void> _listarTipologias() async {
    try {
      this._tipologiaController = TipologiaController(context: this.context);
      this._tipologias = await this._tipologiaController.listar();
    } catch (ex) {}
  }

  Future<void> _listarCidades() async {
    try {
      this._cidadeController = CidadeController(context: this.context);
      this._cidades = await this._cidadeController.listar();
    } catch (ex) {}
    // this._cidadeController.listar().then((List<Cidade> items) {
    //   this._cidades = items;
    //   print(items);
    // }).catchError((error) {
    //   print(error);
    // });
  }

  Future<void> _listarTipoImoveis() async {
    try {
      this._tipoImovelController = TipoImovelController(context: this.context);
      RespostaHttp respostaHttp = await this._tipoImovelController.listar();

      if (respostaHttp.code == HttpStatus.ok) {
        this._tipoImoveis = TipoImovel.mapFromList(respostaHttp.data);
      } else {}
    } catch (ex) {
      print(ex.toString());
    }
  }

  @override
  void didUpdateWidget(covariant FiltrarPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
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
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      child: Column(
                        children: [
                          Container(
                            child: this._botaoVoltarWidget(),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 20),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          this._localidadeFieldWidget(),
                          this._rangeCustoFieldsWidget(),
                          this._tipoImovelFieldWidget(),
                          this._tipologiaFieldWidget(),
                          Container(
                            width: double.infinity,
                            child: TituloPrimario(
                              "Período de Estadia",
                              textAlign: TextAlign.left,
                              fontSize: 18,
                              color: Cores.secundaria(),
                              margin: EdgeInsets.zero,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          this._calendarWidget()
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20, bottom: 50),
                        child: this._botaoFiltrarWidget()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _mostrarModalBottomTipologia(
      BuildContext context, Function onSelection) {
    showModalBottomSheet(
      context: context,
      builder: (builder) => ModalGridItems(
          items: this._tipologias,
          onSelecion: this._setTipologia,
          titulo: "Tipologias"),
    );
  }

  void _mostrarModalBottomCidade(BuildContext context, Function onSelection) {
    showModalBottomSheet(
      context: context,
      builder: (builder) => ModalGridItems(
        items: this._cidades,
        onSelecion: onSelection,
        titulo: "Cidades",
      ),
    );
  }

  void _mostrarModalBottomTipoImovel(
      BuildContext context, Function onSelection) {
    showModalBottomSheet(
      context: context,
      builder: (builder) => ModalGridItems(
        items: this._tipoImoveis,
        onSelecion: onSelection,
        titulo: "Tipo Imoveis",
      ),
    );
  }

  void _setTipologia(Tipologia item) {
    setState(() {
      print(item);
      this.filtering.tipologia = item;
      this._textTipologiaController.text = item.descricao;
    });
  }

  void _setCidade(Cidade item) {
    setState(() {
      print(item);
      this.filtering.cidade = item;
      this._textCidadeController.text = item.denominacao;
    });
  }

  Widget _localidadeFieldWidget() {
    return Container(
      child: CaixaTexto(
        "Cidade, Localidade",
        this.filtering.cidade.denominacao,
        prefixIcon: Icon(Icons.airplanemode_active_outlined),
        sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
        inputType: TextInputType.text,
        readOnly: true,
        onTap: () {
          this._mostrarModalBottomCidade(context, this._setCidade);
        },
        getTexto: (String texto) {
          print(texto);
        },
        controller: this._textCidadeController,
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 10),
    );
  }

  Widget _rangeCustoFieldsWidget() {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: CaixaTexto(
                "Preço Min.",
                "",
                inputType: TextInputType.numberWithOptions(decimal: true),
                prefixIcon: Icon(Icons.attach_money_outlined),
                getTexto: (String texto) {},
                controller: this._textPrecoMinController,
              ),
              alignment: Alignment.topLeft,
            ),
          ),
          this._InputMaxPreco(),
        ],
      ),
    );
  }

  Widget _tipoImovelFieldWidget() {
    return Container(
      child: CaixaTexto(
        "Tipo Imóvel",
        this.filtering.tipoImovel.descricao,
        prefixIcon: Icon(Icons.bed_outlined),
        sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
        inputType: TextInputType.text,
        getTexto: (String texto) {},
        readOnly: true,
        onTap: () {
          this._mostrarModalBottomTipoImovel(
              context, this._selecionarTipoImovel);
        },
        controller: this._textTipoImovelController,
      ),
      alignment: Alignment.topLeft,
    );
  }

  Widget _tipologiaFieldWidget() {
    return Container(
      child: CaixaTexto(
        "Tipologia",
        this.filtering.tipologia.descricao,
        prefixIcon: Icon(Icons.bed_outlined),
        sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
        inputType: TextInputType.emailAddress,
        getTexto: (String texto) {},
        readOnly: true,
        onTap: () {
          this._mostrarModalBottomTipologia(context, this._setTipologia);
        },
        controller: this._textTipologiaController,
      ),
      alignment: Alignment.topLeft,
    );
  }

  Widget _botaoFiltrarWidget() {
    return BotaoIconRight(
      "Procurar Moradia ",
      this._submeterFiltro,
      this.processing
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
    );
  }

  Widget _botaoVoltarWidget() {
    return BotaoBack(
      BotaoModel(
        'Voltar',
        () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _selecionarTipoImovel(TipoImovel tipo) {
    this.setState(() {
      this.filtering.tipoImovel = tipo;
      this._textTipoImovelController.text = tipo.descricao;
    });
  }

  Widget _InputMaxPreco() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: CaixaTexto(
          "Preço Máx.",
          "",
          inputType: TextInputType.numberWithOptions(decimal: true),
          prefixIcon: Icon(Icons.attach_money_outlined),
          getTexto: (String texto) {},
          controller: this._textPrecoMaxController,
        ),
        alignment: Alignment.topLeft,
      ),
    );
  }

  _submeterFiltro() {
    this._mudarProcessing(true);

    this.filtering.precoMin = double.parse(this._textPrecoMinController.text);
    this.filtering.precoMax = double.parse(this._textPrecoMaxController.text);

    this.esperar().then((value) {
      this._mudarProcessing(false);

      print(this.filtering.toMap());
      Navigator.push(context, MaterialPageRoute(builder: (builder) {
        return ResultadoProcuraPagina(
          filtering: this.filtering,
          navigationController: this.widget.navigationController,
        );
      }));
      // this.widget._event(, context);
    });
  }

  void _mudarProcessing(bool state) {
    setState(() {
      this.processing = state;
    });
  }

  Widget _calendarWidget() {
    return Container(
      child: TableCalendar(
        firstDay: DateTime.utc(DateTime.now().year,
            DateTime.now().month, DateTime.now().day),
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
          if (!isSameDay(_selectedDay, selectedDay)) {
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
        onRangeSelected: (start, end, focusedDay) {
          setState(() {
            _selectedDay = null;
            _focusedDay = focusedDay;
            _rangeStart = start;
            _rangeEnd = end;
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
    );
  }
}
