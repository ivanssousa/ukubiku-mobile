import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ItemGrelha extends StatelessWidget
{
  Galeria galeria = Galeria.novo();
  ItemGrelha({Key? key, Galeria? imagem})
  {
    if ( imagem != null )
    this.galeria = imagem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Center(
          child: Text(
            "Imagem da Galeria",
            textAlign: TextAlign.center
          ),
        ),
        onTap: () {
          print("Item Galeria");
        },
      ),
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
      ),
    );
  }
}

class GrelhaGaleria extends StatelessWidget {
  List<Galeria> imagens = List.empty(growable: true );

  GrelhaGaleria(this.imagens, {Key? key}) : super(key: key);

  containerVazio() {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: 10
      ),
      child: Text(
        "Não existem imagens.",
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: TituloPrimario(
            "Galeria",
            fontSize: 18,
            color: Cores.secundaria(),
            textAlign: TextAlign.start,
            margin: EdgeInsets.only(
              top: 20,
              bottom: 0,
            ),
          ),
        ),
        this.imagens.length < 1 ? this.containerVazio() : Container(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 10,
            ),
            itemCount: this.imagens.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 15),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, index ) {
              return ItemGrelha( imagem: this.imagens[index] );
              return Text("Exemplo", style: TextStyle(
                color: Colors.black
              ),);
            }
          )
        )
      ],
    );
  }
}
