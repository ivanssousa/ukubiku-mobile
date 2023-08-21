import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/apresentacao/widgets/aluguer_list_view.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/data/pagina_filtrar_data.dart';
import 'package:ukubiku/src/apresentacao/widgets/imovel_list_view.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AluguerController.dart';
import 'package:ukubiku/src/domain/controllers/ImovelController.dart';
import 'package:ukubiku/src/utils/cores.dart';

class AlugadoPage extends StatefulWidget {
  static String routeName = "/alugado_page";

  late NavigationController navigationController;

  AlugadoPage({Key? key, required this.navigationController}) : super(key: key);

  @override
  _AlugadoPageState createState() => _AlugadoPageState();
}

class _AlugadoPageState extends State<AlugadoPage> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  late PaginaFiltrarData filtering;
  late TextEditingController _cidadeTextController =
      TextEditingController(text: "");
  late AluguerController _aluguerController;
  late ImovelController _imovelController;
  late int _totalImoveis;

  late List<Imovel> items = List.empty(growable: true);
  late List<Aluguer> alugers = List.empty(growable: true);

  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._totalImoveis = 0;

    this._imovelController = ImovelController(context: context);
    this._aluguerController = AluguerController(context: context);

    this._listarALuguers();

    this._loading = true;
  }

  @override
  void didUpdateWidget(covariant AlugadoPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    this._loading = false;
  }

  void _listarALuguers() {
    this._aluguerController.lista().then((value) {
      setState(() {
        this.alugers = value;
        this._loading = false;
        this._totalImoveis = this.alugers.length;
      });
    }).catchError((error) {
      // print(error);
      SnackBarErro("Não foi possível carregar o aluguer", () {}, this.context)
          .show();
      this.alugers = [];
      this._loading = false;
    });
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
            left: 10,
            right: 10,
            top: 50,
          ),
          height: MediaQuery.of(context).size.height,
          child: Container(
            child: Stack(
              children: [
                Container(
                  child: BotaoBack(
                    BotaoModel(
                      'Voltar',
                      () {
                        this
                            .widget
                            .navigationController
                            .voltar(context, RootUserPage.routeName);
                      },
                    ),
                  ),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 0),
                ),
                Container(
                  child: TituloPrimario(
                    "Lista de Alugados ("+this.alugers.length.toString()+")",
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    margin: EdgeInsets.only(top: 15),
                  ),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 0, left: 200, bottom: 0),
                ),
                Container(
                  margin: EdgeInsets.only(top: 70),
                  child: this._loading
                      ? this._showLoading()
                      : this._mostrarLista(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showLoading() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: CircularProgressIndicator(
              color: Cores.primaria(),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 100),
              child: TextoDescricao("Carregando..", TextAlign.center))
        ],
      ),
    );
  }

  Widget _mostrarLista() {
    return AluguerListView(
      lista: this.alugers,
      totalItems: this.alugers.length,
      navigationController: this.widget.navigationController,
      carregarMais: (ImovelListViewState item) {
        item.widget.lista = this.items;
        this._imovelController.listar().then((RespostaHttp value) {
          Future.delayed(Duration(seconds: 3), () {
            setState(() {
              item.widget.lista.addAll(Imovel.mapFromList(value.data));
              item.isLoading = false;
            });
          });
        }).catchError((error) {
          item.isLoading = false;
        });
      },
    );
  }
}
