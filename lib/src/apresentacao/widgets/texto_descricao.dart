import 'package:flutter/material.dart';
import 'package:ukubiku/src/utils/cores.dart';


class TextoDescricao extends StatelessWidget
{
  String _descricao;
  TextAlign _align;
  EdgeInsets _margin = EdgeInsets.all(0);
  Color _color  = Cores.cinza();
  Function _onTap = () {};
  Icon _icon  = Icon( Icons.add );

  TextAlign _textAlign = TextAlign.left;
  double _fontSize = 15;
  FontWeight _fontWeight = FontWeight.w400;


  TextoDescricao(this._descricao, this._align, {
      Key? key,
      EdgeInsets? margin,
      Color? color,
      Function? onPress,
      Icon? icon,
      TextAlign? textAlign,
      double? fontSize,
      FontWeight? fontWeight
  })
  {
    if ( margin != null )
      this._margin = margin;
    if ( color != null )
      this._color = color;
    if ( onPress != null )
      this._onTap = onPress;
    if ( icon != null )
      this._icon = icon;

    if ( textAlign != null )
      this._textAlign = textAlign;
    if ( fontSize != null )
      this._fontSize  = fontSize;
    if ( fontWeight != null )
      this._fontWeight  = fontWeight;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this._margin,
      width: double.infinity,
      child: GestureDetector(
        onTap: (){
          this._onTap();
        },
        child: Text(
          this._descricao,
          textAlign: this._align,
          style: TextStyle(
            fontSize: this._fontSize,
            color: this._color,
            fontWeight: this._fontWeight
          ),
        ),
      )
    );
  }
}


