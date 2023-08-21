import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/alugado/index.dart';
import 'package:ukubiku/src/apresentacao/pages/favorito/index.dart';
import 'package:ukubiku/src/apresentacao/pages/filtrar_page.dart';
import 'package:ukubiku/src/apresentacao/pages/pagina_inicial_page.dart';
import 'package:ukubiku/src/apresentacao/pages/perfil_cliente_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/utils/cores.dart';

class BottomNavigator extends StatefulWidget
{
  BottomNavigator({Key? key}) : super(key: key);

  NavigationController navigationController = NavigationController();

  static int MIN_INDEX_ROUTE = 0;
  static String DEFAULT_ROUTE = PaginaInicialPage.routeName;

  static List<String> items = [
    PaginaInicialPage.routeName,
    FiltrarPage.routeName,
    FavoritoPage.routeName,
    AlugadoPage.routeName,
    PerfilClientePage.routeName
  ];

  static int getIndexOfPage( String route )
  {
    int index = -1;
    if ( route.isNotEmpty )
      index = items.indexWhere((element) => element == route );
    else
      index = items.indexWhere((element) => element == DEFAULT_ROUTE );
    return index >= MIN_INDEX_ROUTE ? index : MIN_INDEX_ROUTE;
  }

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  List<String> routes = [PaginaInicialPage.routeName,FiltrarPage.routeName,PaginaInicialPage.routeName,PerfilClientePage.routeName];

  // static List<Widget> _widgetOptions = <Widget>[
  //   PaginaInicialPage( navigationController:  this.widget),
  //   Text(
  //     'Index 1: Business',
  //     style: optionStyle,
  //   ),
  //   Text(
  //     'Index 2: Business',
  //     style: optionStyle,
  //   ),
  //   PerfilClientePage(),
  // ];

  void _onItemTapped(index, context) {
    Navigator.restorablePushNamed(context, this.routes[ index ] );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedIconTheme: IconThemeData(
        color: Cores.primaria(),
      ),
      unselectedIconTheme: IconThemeData(
        color: Cores.secundaria(),
      ),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
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
          icon: Icon(Icons.account_circle_outlined),
          label: 'Pefil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Cores.primaria(),
      onTap: (index) {
        _onItemTapped(index, context );
      },
    );
  }
}


