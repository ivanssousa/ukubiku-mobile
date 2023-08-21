import 'package:flutter/material.dart';
import 'package:ukubiku/src/utils/cores.dart';


class TituloPrimario extends StatelessWidget
{
  String _descricao;
  TextAlign _align = TextAlign.center;
  EdgeInsets _margin = EdgeInsets.only(top: 30, bottom: 10);
  TextAlign _textAlign = TextAlign.left;
  double _fontSize  = 30;
  Color _color      = Cores.primaria();
  FontWeight _fontWeight  = FontWeight.bold;

  TituloPrimario(this._descricao, {Key? key, EdgeInsets? margin, TextAlign? textAlign, double? fontSize, Color? color, FontWeight? fontWeight}) {

    if ( margin != null )
      this._margin = margin;
    if ( textAlign != null )
      this._textAlign = textAlign;
    if ( fontSize != null )
      this._fontSize  = fontSize;
    if ( color != null )
      this._color = color;

    if ( fontWeight != null )
      this._fontWeight  = fontWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this._margin,
      child: Text(
        this._descricao,
        textAlign: this._textAlign,
        style: TextStyle(
          fontSize: this._fontSize,
          color:  this._color,
          fontWeight: this._fontWeight
        ),
      ),
    );
  }
}
