import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/alugado/index.dart';
import 'package:ukubiku/src/apresentacao/pages/favorito/index.dart';
import 'package:ukubiku/src/apresentacao/pages/filtrar_page.dart';
import 'package:ukubiku/src/apresentacao/pages/pagina_inicial_page.dart';
import 'package:ukubiku/src/apresentacao/pages/perfil_cliente_page.dart';
import 'package:ukubiku/src/apresentacao/pages/resultado_procura_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/data/pagina_filtrar_data.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/bottom_navigation.dart';
import 'package:ukubiku/src/utils/cores.dart';

class RootUserPage extends StatefulWidget {
  static const routeName = '/root_user_page';
  late String _keyItemSelected = "";

  RootUserPage({Key? key, String? keyItemSelected}) {
    if (keyItemSelected != null) this._keyItemSelected = keyItemSelected;
  }

  @override
  _RootUserPageState createState() => _RootUserPageState();
}

class _RootUserPageState extends State<RootUserPage>
{
  late NavigationController navigationController = NavigationController();

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  late List<Widget> _widgetOptions;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.navigationController = NavigationController();
    this._widgetOptions = <Widget>[
      PaginaInicialPage(navigationController: this.navigationController),
      FiltrarPage(navigationController: this.navigationController),
      FavoritoPage(),
      AlugadoPage(
        navigationController: this.navigationController,
      ),
      PerfilClientePage(),
    ];

    int index = BottomNavigator.getIndexOfPage(this.widget._keyItemSelected);

    this._onItemTapped(index);
  }

  @override
  void didUpdateWidget(covariant RootUserPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(
          color: Cores.primaria(),
        ),
        unselectedIconTheme: IconThemeData(
          color: Cores.secundaria(),
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Filtrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_alert_outlined),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Alugados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Pefil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Cores.primaria(),
        onTap: _onItemTapped,
      ),
    );
  }
}
