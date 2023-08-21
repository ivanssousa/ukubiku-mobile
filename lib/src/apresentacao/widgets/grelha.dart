import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ItemGrelha extends StatelessWidget {
  Object object = Object();
  Function onPress = () {};

  ItemGrelha({Key? key, required this.object, required this.onPress}) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 30),
              child: Text(
                this.object.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Cores.secundaria(),
                  fontSize: 12,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          this.onPress();
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
        border: Border.all(color: Colors.black26),
        image: const DecorationImage(
          alignment: Alignment(0, 0),
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/item_publicacao.jpeg",
          ),
          colorFilter: ColorFilter.mode(Color.fromRGBO(255, 255, 255, 150), BlendMode.modulate )
        )
      ),
    );
  }
}

class Grelha extends StatelessWidget
{
  List<Object> items = List.empty(growable: true);
  String titulo;
  late ItemGrelha itemSelecionado;
  late Function onSelect;

  Grelha({Key? key, required this.items, required this.titulo, required this.onSelect })
  {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: TituloPrimario(
            this.titulo,
            fontSize: 18,
            color: Cores.secundaria(),
            textAlign: TextAlign.start,
            margin: EdgeInsets.only(
              top: 20,
              bottom: 0,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
            ),
            itemCount: this.items.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 15),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index) {
              return ItemGrelha(object: this.items[index], onPress: () {
                this.onSelect( this.items[index] );
              });
            },
          ),
        )
      ],
    );
  }
}
