import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/filtrar_page.dart';
import 'package:ukubiku/src/apresentacao/pages/item_selecionado_page.dart';
import 'package:ukubiku/src/apresentacao/pages/perfil_cliente_page.dart';
import 'package:ukubiku/src/apresentacao/pages/root_user_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/data/pagina_filtrar_data.dart';
import 'package:ukubiku/src/apresentacao/widgets/icon_categoria.dart';
import 'package:ukubiku/src/apresentacao/widgets/imagem_perfil.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_publicacao_recente.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/AuthController.dart';
import 'package:ukubiku/src/domain/controllers/TipoImovelController.dart';
import 'package:ukubiku/src/domain/controllers/ImovelController.dart';
import 'package:ukubiku/src/settings/storage/local_storage.dart';
import 'package:ukubiku/src/utils/cores.dart';

class PaginaInicialPage extends StatefulWidget {
  static const routeName = '/pagina_inicial_page';

  late PaginaFiltrarData data;
  late List<TipoImovel> result;

  NavigationController navigationController;
  late LocalStorage localStorage;

  PaginaInicialPage({required this.navigationController}) {
    this.data = PaginaFiltrarData();
    this.result = List.empty(growable: true);
    this.localStorage = LocalStorage.getInstance();
  }

  @override
  _PaginaInicialPageState createState() => _PaginaInicialPageState();
}

class _PaginaInicialPageState extends State<PaginaInicialPage> {
  late TipoImovelController tipoImovelController;
  late ImovelController imovelController;

  late AuthController authController;
  User? user;

  late bool loadedTipoImoveis, loadedImoveisRecentes, loadedImoveisRecomendados;

  List<Widget> listTipoImoveisWidget = List.empty(growable: true);
  List<Widget> listImoveisWidget = List.empty(growable: true);


  @override
  initState() {
    super.initState();
    this.tipoImovelController = new TipoImovelController(context: this.context);
    this.imovelController = new ImovelController(context: this.context);

    this.loadedTipoImoveis =
        this.loadedImoveisRecentes = this.loadedImoveisRecomendados = false;

    this.authController = AuthController();
    this.authController.user().then((User value) {
      setState(() {
        this.user = value;
        print(this.user?.rh_pessoa_id.nome);
      });
    }).catchError((error) {
      print(error.toString());
    });

    if (this.widget.localStorage != null)
      print("Token: " + this.widget.localStorage.getToken());
  }

  @override
  void didChangeDependencies() {
    print('Widget Lifecycle: didChangeDependencies');
    super.didChangeDependencies();

    this.listarCategorias();
    this.listarImoveis();
  }

  @override
  void didUpdateWidget(covariant PaginaInicialPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('Widget Lifecycle: didUpdateWidget');

    this.listarCategorias();
    this.listarImoveis();
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
        backgroundColor: Cores.branco(),
        body: WillPopScope(
          onWillPop: _isExitDesired,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Stack(
                  children: [
                    this._header(),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(top: 290),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TituloPrimario(
                              'Tipo Imóveis',
                              textAlign: TextAlign.left,
                              color: Cores.secundaria(),
                              fontSize: 18,
                              margin: EdgeInsets.only(
                                top: 50,
                                left: 20,
                              ),
                            ),
                          ),
                          this._menuWidgets(),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TituloPrimario(
                              'Recentes',
                              textAlign: TextAlign.left,
                              color: Cores.secundaria(),
                              fontSize: 18,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 20,
                              ),
                            ),
                          ),
                          this._imoveisRecentesWidget(),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: TituloPrimario(
                              'Recomendadas',
                              textAlign: TextAlign.left,
                              color: Cores.secundaria(),
                              fontSize: 18,
                              margin: EdgeInsets.only(
                                top: 10,
                                left: 20,
                              ),
                            ),
                          ),
                          this._imoveisRecomendadosWidget(),
                        ],
                      ),
                    ),
                    this._pesquisarWidget()
                  ],
                ),
              ],
            ),
          ),
        ));
  }



  Future<bool> _isExitDesired() async
  {
    return await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Confirmar"),
            content: const Text("Deseja fechar a aplicação"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Confirmar")
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("Cancelar")
              )
            ],
          );
        }
    ) ?? false ;
  }


  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        color: Cores.secundaria(),
      ),
      child: Stack(
        children: [
          Container(
            height: 150,
            padding: EdgeInsets.only(
              left: 40,
              right: 40,
              top: 10,
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(
                    this.user != null
                        ? this.user?.rh_pessoa_id.nome as String
                        : 'Página Inicial',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  child: ImagemPerfil(
                    width: 50,
                    height: 50,
                    onTap: this._navegarParaPerfil,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 40,
              bottom: 40,
            ),
            height: 150,
            margin: EdgeInsets.only(top: 120, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Incluir slides de Publicidade',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void listarCategorias() {
    this.tipoImovelController.listar().then((resposta) {
      if (resposta.code == HttpStatus.ok) {
        List<TipoImovel> lista = TipoImovel.mapFromList(resposta.data);
        List<Widget> widgets = this._construirTipoImoveis(lista);

        setState(() {
          this.listTipoImoveisWidget = widgets;
          this.loadedTipoImoveis = true;
        });
      } else {
        setState(() {
          this.listTipoImoveisWidget = [];
          this.loadedTipoImoveis = true;
        });
      }
    }).catchError((erro) {
      setState(() {
        this.listTipoImoveisWidget = [];
        this.loadedTipoImoveis = true;
      });
    });
  }

  void listarImoveis() async {
    this.imovelController.listar().then((resposta) {
      if (resposta.code == HttpStatus.ok) {
        List<Imovel> lista = Imovel.mapFromList(resposta.data);
        List<Widget> temp = this._construirImoveis(lista);

        setState(() {
          this.listImoveisWidget = temp;
          this.loadedImoveisRecentes = true;
          this.loadedImoveisRecomendados = true;
        });
      } else {
        setState(() {
          this.listImoveisWidget = [];
          this.loadedImoveisRecentes = true;
          this.loadedImoveisRecomendados = true;
        });
      }
    }).catchError((erro) {});
  }

  void _navegarParaPerfil() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) =>
            RootUserPage(keyItemSelected: PerfilClientePage.routeName),
      ),
    );
  }

  Future<void> resolverFiltro(PaginaFiltrarData page, BuildContext c) async {
    await Future.delayed(Duration(seconds: 2));
  }

  List<Widget> _construirTipoImoveis(List<TipoImovel> list) {
    Map<String, dynamic> icones = Map();
    icones.putIfAbsent("APARTAMENTO", () => Icons.account_balance_outlined);
    icones.putIfAbsent("RESIDENCIA", () => Icons.home_outlined);
    icones.putIfAbsent("Quarto", () => Icons.account_balance_outlined);
    icones.putIfAbsent('COBERTURA', () => Icons.account_balance_outlined);
    List<Widget> temp = List.empty(growable: true);

    for (TipoImovel item in list) {
      temp.add(
        IconCategoria(
          iconData: icones[item.codigo],
          texto: item.descricao.length > 9
              ? item.descricao.substring(0, 10)
              : item.descricao.substring(0, 6),
          onPress: () {
            this.widget.data.tipoImovel = item;
            print(item.descricao);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => FiltrarPage(
                  data: this.widget.data,
                  navigationController: this.widget.navigationController,
                ),
              ),
            );
          },
        ),
      );
    }
    return temp;
  }

  List<Widget> _construirImoveis(List<Imovel> list) {
    List<Widget> result = List.empty(growable: true);
    for (Imovel item in list) {
      result.add(ItemPublicacaoRecente(
        onPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (builder) => ItemSelecionadoPage(item),
            ),
          );
        },
        onAddFavorito: (Imovel imovel) {
          List<Imovel> lista = [
            Imovel.empty(),
            Imovel.empty(),
            Imovel.empty(),
            Imovel.empty(),
            Imovel.empty()
          ];

          print(jsonEncode(lista));
        },
        publicacao: item,
      ));
    }
    return result;
  }

  Widget _menuWidgets() {
    if (this.listTipoImoveisWidget.length < 1) {
      return this._containerVazio(
          "Tipos de Imóveis não encontrados.", this.loadedTipoImoveis);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: Row(
          children: this.listTipoImoveisWidget,
        ),
      ),
    );
  }

  Widget _imoveisRecentesWidget() {
    if (this.listImoveisWidget.length < 1) {
      return this._containerVazio(
          "Imóveis Indisponiveis.", this.loadedImoveisRecentes);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: Row(
          children: this.listImoveisWidget,
        ),
      ),
    );
  }

  Widget _imoveisRecomendadosWidget() {
    if ( true ) {
      print("Recomendados Carregado");
      return this._containerVazio("Imóveis Recomendados não Disponiveis.",
          this.loadedImoveisRecomendados);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.only(
          top: 10,
          left: 20,
        ),
        child: Row(
          children: this.listImoveisWidget,
        ),
      ),
    );
  }

  Widget _pesquisarWidget() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      color: Colors.white,
      margin: EdgeInsets.only(
        top: 240,
        left: 20,
        right: 20,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Container(
            width: double.infinity,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Container(
                    child: BotaoIcone(
                        iconData: Icons.bubble_chart_outlined,
                        onPress: () {
                          this
                              .widget
                              .navigationController
                              .toBottomMenu(context, FiltrarPage.routeName);
                        }))
              ],
            )),
      ),
    );
  }

  Widget _containerVazio(String label, bool loaded) {
    if (!loaded) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: Container(
          width: 20,
          height: 20,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
      child: Row(
        children: [
          Container(
            width: 40,
            child: Icon(
              Icons.widgets_outlined,
              size: 30,
            ),
          ),
          Container(
            child: Expanded(
              child: Text(
                label,
                style: TextStyle(
                    color: Cores.primaria(),
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _acaoFechar() async {
    print("asss");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar"),
        content: Text("Deseja Fechar a aplicação?"),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("Explorar Mais"),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("Confirmar"),
          )
        ],
      ),
    );

    return false;
  }
}
