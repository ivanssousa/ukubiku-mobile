import 'package:flutter/material.dart';
import 'package:ukubiku/src/utils/cores.dart';

class BotaoIcone extends StatelessWidget {
  IconData  iconData;
  Function  onPress;
  double    radius    =  30;
  double    _height   =  35;
  double    _width    =  35;
  double    _sizeIcon =  30;
  Color     cor  = Cores.primaria();

  BotaoIcone
  ({
      Key? key,
      required this.iconData,
      required this.onPress,
      double? radius,
      Color? background,
      double? height,
      double? width,
      double? sizeIcon
  })
  {
    if ( radius != null )
      this.radius = radius;
    if ( background != null )
      this.cor    = background;
    if ( height != null )
      this._height  = height;
    if ( width != null )
      this._width = width;
    if ( sizeIcon != null )
      this._sizeIcon  = sizeIcon;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular( this.radius) ),
        ),
        minimumSize:
        MaterialStateProperty.all<Size>(Size(this._width, this._height)),
        padding:
        MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(15)),
        backgroundColor: MaterialStateProperty.all<Color>( this.cor ),
      ),
      onPressed: (){
        this.onPress();
      },
      child: Icon(
        this.iconData,
        size: this._sizeIcon,
        color: Colors.white,
      ),
    );
  }
}
