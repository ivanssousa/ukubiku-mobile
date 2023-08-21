import 'package:flutter/material.dart';

class ComponenteVazio extends StatefulWidget
{
  late String label;
  late bool loaded;

  ComponenteVazio({Key? key, required this.label, required this.loaded }) : super(key: key);

  @override
  _ComponenteVazioState createState() => _ComponenteVazioState();
}

class _ComponenteVazioState extends State<ComponenteVazio> {

  @override
  Widget build(BuildContext context) {
    if ( this.widget.loaded )
    {
      return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
          child: Column(
            children: [
              Text( this.widget.label )
            ],
          )
      );
    }
    return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20, top: 20, bottom: 20),
        child: Container(
          width: 20,
          height: 20,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
    );
  }
}


