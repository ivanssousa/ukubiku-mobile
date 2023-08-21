import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/item_selecionado_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/navigation/NavigationController.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ItemResultadoAlugado extends StatelessWidget {
  late EdgeInsets _margin;
  late Aluguer _aluguer;
  late NavigationController navigationController;
  late Function onPress;

  ItemResultadoAlugado(
      {
        Key? key,
        EdgeInsets? margin,
        Aluguer? aluguer,
        required this.navigationController,
        required this.onPress
      }
  )
  {
    this._margin = margin != null ? margin : EdgeInsets.only(bottom: 5);
    this._aluguer = aluguer != null ? aluguer : Aluguer.nova();
  }

  int totalPessoas() {
    if ( this._aluguer.hospedes != null )
      return this._aluguer.hospedes.length;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: this._margin,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                    this._aluguer.imovel.titulo.length > 17
                        ? this._aluguer.imovel.titulo.substring(0, 17) + "..."
                        : this._aluguer.imovel.titulo,
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
                          this._aluguer.getHorarioInicial+' Até '+this._aluguer.getHorarioFinal,
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
                          (this._aluguer.totalDiasEstadia.toString()+" (dias)"),
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
                    this._aluguer.estadoAluguerId.codigo ,
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
          this.onPress( this._aluguer );
        },
      ),
    );
  }
}
