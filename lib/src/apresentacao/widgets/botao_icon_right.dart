import 'dart:ui';

import 'package:flutter/material.dart';
import '../../utils/cores.dart';

class BotaoIconRight extends StatelessWidget {
  String _title = 'Title Button';
  Function _event;
  double _width = 250;
  double _height = 50;
  EdgeInsets _margin = EdgeInsets.all(0);
  Widget childContainerIcon;
  Color _background = Cores.primaria();


  BotaoIconRight(this._title, this._event, this.childContainerIcon,
      {Key? key, double? width, double? height, EdgeInsets? margin, Color? background}) {
    if (width != null) this._width = width;
    if (height != null) this._height = height;
    if (margin != null) this._margin = margin;
    this._background  = background ?? Cores.secundaria();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          minimumSize:
              MaterialStateProperty.all<Size>(Size(this._width, this._height)),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15)),
          backgroundColor: MaterialStateProperty.all<Color>(this._background),
        ),
        onPressed: () => this._event(),
        child: Stack(
          children: [
            Container(
              child: Text(
                this._title.toUpperCase(),
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              margin: EdgeInsets.only(
                top: 5,
              ),
            ),
            Container(
              child: this.childContainerIcon,
              margin: EdgeInsets.only(
                left: 200,
              ),
            )
          ],
        ));
  }
}
