import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import '../../utils/cores.dart';

class BotaoContainer extends StatelessWidget {
  String _title = 'Title Button';
  double _height = 50;
  EdgeInsets _margin = EdgeInsets.all(0);
  IconData _icon = Icons.arrow_back_ios_outlined;
  Color _color = Cores.primaria();

  BotaoModel _botaoBackModel;

  BotaoContainer(this._botaoBackModel,
      {Key? key, double? width, double? height, EdgeInsets? margin, IconData? icon })
  {
    if (height != null) this._height  = height;
    if (margin != null) this._margin  = margin;
    if (icon != null ) this._icon    = icon;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular( this._height  )),
        ),
        padding:
            MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0)),
      ),
      onPressed: () => this._botaoBackModel.event(),
      child: Card(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  this._botaoBackModel.label.toUpperCase(),
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontWeight: FontWeight.bold, color: this._color),
                ),
                Icon(this._icon, color: Cores.primaria() ),
              ],
            ),
          )
        ),

    );
  }
}
