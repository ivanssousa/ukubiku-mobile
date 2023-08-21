import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/grelha.dart';
import 'package:ukubiku/src/data/models/models.dart';

class ModalGridItems extends StatelessWidget
{
  late List<Object> items;
  late Function onSelecion;
  late String titulo;

  ModalGridItems({Key? key, required this.items, required this.onSelecion, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    height = height * 0.5;

    return Container(
      height: height,
      child: Grelha(
        items: this.items,
        titulo: this.titulo,
        onSelect: (Object item) {
          this.onSelecion( item );
          Navigator.pop(context);
        },
      ),
    );
  }
}
