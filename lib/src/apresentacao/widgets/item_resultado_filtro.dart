import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/item_selecionado_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ItemResultadoFiltro extends StatelessWidget
{
  late EdgeInsets _margin;
  late Imovel _imovel;
  late NavigationController navigationController;

  ItemResultadoFiltro(
      {Key? key, EdgeInsets? margin, Imovel? imovel, required this.navigationController}
  )
  {
    this._margin = margin != null ? margin : EdgeInsets.only( bottom: 5 );
    this._imovel = imovel != null ? imovel : Imovel.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: this._margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Stack(
              children: [
                Container(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const Image(
                        alignment: Alignment.centerLeft,
                        width: 120,
                        height: 120,
                        image: AssetImage("assets/images/item_publicacao.jpeg"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 140,
                    top: 10,
                  ),
                  child: Text(
                    this._imovel.titulo.length > 17 ? this._imovel.titulo.substring(0, 17)+"..." : this._imovel.titulo,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 140,
                    top: 65,
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.people_outline,
                            size: 15,
                          )),
                      Expanded(
                        child: Text(
                          'Para 2 Pessoas',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Cores.cinza(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 140,
                    top: 40,
                  ),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.event_outlined,
                            size: 15,
                          )),
                      Expanded(
                        child: Text(
                          'Disponível em 3 dias',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Cores.cinza(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 140,
                    top: 90,
                  ),
                  child: Text(
                    this._imovel.custo.toString()+' Kz/dia',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Cores.secundaria(),
                      fontSize: 17,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    left: 140,
                    top: 115,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Cores.laranja(),
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Cores.laranja(),
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Cores.laranja(),
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Cores.laranja(),
                      ),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Cores.laranja(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        onTap: () {
          this.navigationController.navigateTo(
            context,
            ItemSelecionadoPage(
             this._imovel
          ));
        },
      ),
    );
  }
}
