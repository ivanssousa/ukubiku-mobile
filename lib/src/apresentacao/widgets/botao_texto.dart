import 'dart:ui';

import 'package:flutter/material.dart';
import '../../utils/cores.dart';

class BotaoTexto extends StatelessWidget {
  String _title   = 'Title Button';
  Function _event;
  double _width   = 250;
  double _height  = 50;
  EdgeInsets _margin  = EdgeInsets.all(0);
  Icon  _icon = Icon( Icons.arrow_back_ios_outlined );

  BotaoTexto(this._title, this._event ,  {Key? key, double? width, double? height, EdgeInsets? margin})
  {
    if ( width != null )
      this._width = width;
    if ( height != null )
      this._height  = height;

    if ( margin != null )
      this._margin  = margin;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton (
      style: ButtonStyle (
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25)
          ),
        ),
        minimumSize: MaterialStateProperty.all<Size>( Size( this._width , this._height ) ),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>( EdgeInsets.all(15) ),
        backgroundColor: MaterialStateProperty.all<Color>( Cores.primaria() ),
      ),
      onPressed: () => this._event(),
      child: Text(
        this._title.toUpperCase(),
        textDirection: TextDirection.ltr,
        style: TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
