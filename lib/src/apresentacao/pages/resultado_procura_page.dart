import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/filtrar_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icon_right.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/imovel_list_view.dart';
import 'package:ukubiku/src/apresentacao/widgets/data/pagina_filtrar_data.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_resultado_filtro.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/bottom_navigation.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/ImovelController.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ResultadoProcuraPagina extends StatefulWidget {
  static const routeName = '/filtrar_page';
  TipoImovel? tipoImovel;
  late PaginaFiltrarData filtering;
  late NavigationController navigationController;

  ResultadoProcuraPagina({Key? key, this.tipoImovel, required this.filtering, required this.navigationController})
      : super(key: key);

  @override
  _ResultadoProcuraPaginaState createState() => _ResultadoProcuraPaginaState();
}

class _ResultadoProcuraPaginaState extends State<ResultadoProcuraPagina>
{
  late PaginaFiltrarData filtering;
  late TextEditingController _cidadeTextController = TextEditingController(text: "");

  late ImovelController _imovelController;
  late int _totalImoveis;
  late List<Imovel> items = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._totalImoveis = 0;

    if (this.widget.filtering != null) {
      this.filtering = this.widget.filtering;
      this._cidadeTextController.text = this._getTextoFiltro();
    }

    this._imovelController = ImovelController(context: context);
    this._listarImoveis();
  }

  void _listarImoveis()
  {
    this._imovelController.getTotalDisponivel(Map()).then((RespostaHttp value) {
      setState(() {
        this._totalImoveis = value.data as int;
      });
    }).catchError((error) {
      print(error);
    });

    this._imovelController.listar().then((RespostaHttp value) {
      setState(() {
        this.items = Imovel.mapFromList(value.data);
        print(items);
      });
    }).catchError((error) {});
  }

  @override
  void didUpdateWidget(covariant ResultadoProcuraPagina oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                          this._headerWidget(),
                          Container(
                            height: (MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.30),
                            child: ImovelListView(
                              lista: this.items,
                              totalItems: this._totalImoveis,
                              navigationController: this.widget.navigationController,
                              carregarMais: (ImovelListViewState item) {
                                item.isLoading = true;
                                this._imovelController.listar().then((RespostaHttp value) {
                                  Future.delayed(Duration(seconds: 3), (){
                                    setState(() {
                                      item.widget.lista.addAll( Imovel.mapFromList(value.data) );
                                      item.isLoading = false;
                                    });
                                  });
                                }).catchError((error) {
                                  item.isLoading = false;
                                });
                              },
                            ),
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
    );
  }

  String getFiltro() {
    return this.filtering.cidade.denominacao;
  }

  Widget _headerWidget() {
    return Column(
      children: [
        this._filtroInput(),
        Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              this._escolherDataWidget(),
              this._escolherDataTipoImovel()
            ],
          ),
        ),
      ],
    );
  }

  void _navegarFiltro() {
    Navigator.pop(context);
  }

  String _getTextoFiltro() {
    return this.filtering.cidade.denominacao +
        ", " +
        this.filtering.tipoImovel.descricao +
        ", " +
        this.filtering.tipologia.descricao;
  }

  Widget _filtroInput() {
    return Container(
      child: CaixaTexto(
        this.widget.tipoImovel == null ? "Filtros" : this.getFiltro(),
        "",
        prefixIcon: Icon(
          Icons.search_outlined,
        ),
        sufixIcon: Icon(Icons.arrow_forward_ios_outlined),
        inputType: TextInputType.emailAddress,
        readOnly: true,
        getTexto: (String texto) {
          print(texto);
        },
        onTap: () {
          this._navegarFiltro();
        },
        controller: this._cidadeTextController,
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(top: 0),
    );
  }

  Widget _escolherDataWidget() {
    return Expanded(
      child: InkWell(
        child: Stack(
          children: [
            Container(
              child: Icon(Icons.event_outlined),
              margin: EdgeInsets.only(
                right: 0,
                left: 10,
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 10, top: 5),
              child: Text('Escolher Data'),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                left: 0,
                top: 30,
              ),
              child: const Text(
                '18 de Agosto de 2022',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          print('Escolher Data');
        },
      ),
    );
  }

  Widget _escolherDataTipoImovel() {
    return Expanded(
      child: InkWell(
        child: Stack(
          children: [
            Container(
              child: const Icon(Icons.bed_outlined),
              margin: const EdgeInsets.only(left: 20),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, top: 5),
              child: const Text('Tipo Imóvel'),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                left: 0,
                top: 30,
              ),
              child: Text(
                this.filtering.tipoImovel.descricao,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          print('Escolher Quarto');
        },
      ),
    );
  }
}
