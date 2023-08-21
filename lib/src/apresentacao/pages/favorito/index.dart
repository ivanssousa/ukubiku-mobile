import 'package:flutter/material.dart';

class FavoritoPage extends StatefulWidget {
  static const routeName = '/favorito_page';

  const FavoritoPage({Key? key}) : super(key: key);

  @override
  _FavoritoPageState createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {

  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Index 2: Business',
        style: optionStyle,
      ),
    );
  }
}
