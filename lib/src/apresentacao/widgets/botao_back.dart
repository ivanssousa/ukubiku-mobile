import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import '../../utils/cores.dart';

class BotaoBack extends StatelessWidget {
  String _title = 'Title Button';
  double _width = 250;
  double _height = 50;
  EdgeInsets _margin = EdgeInsets.all(0);
  Color _color = Cores.primaria();

  BotaoModel _botaoBackModel;

  BotaoBack(this._botaoBackModel,
      {Key? key,
      double? width,
      double? height,
      EdgeInsets? margin,
      Color? cor}) {
    if (width != null) this._width = width;
    if (height != null) this._height = height;

    if (margin != null) this._margin = margin;
    if (cor != null) this._color = cor;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          minimumSize:
              MaterialStateProperty.all<Size>(Size(this._width, this._height)),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(0)),
        ),
        onPressed: () => this._botaoBackModel.event(),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios_outlined, color: this._color ),
            Text(
              this._botaoBackModel.label.toUpperCase(),
              textDirection: TextDirection.ltr,
              style: TextStyle(fontWeight: FontWeight.bold, color: this._color),
            ),
          ],
        ));
  }
}
