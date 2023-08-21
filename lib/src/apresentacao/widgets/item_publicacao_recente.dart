import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/settings/storage/favorito_storage.dart';
import 'package:ukubiku/src/utils/cores.dart';

class ItemPublicacaoRecente extends StatelessWidget {
  Function onPress;
  Imovel publicacao;
  Function onAddFavorito;

  ItemPublicacaoRecente({
    Key? key,
    required this.onPress,
    required this.publicacao,
    required this.onAddFavorito})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.onPress();
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Card(
              margin: EdgeInsets.only(top: 0),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        alignment: Alignment(0, 0),
                        width: 200,
                        image: AssetImage(
                          "assets/images/item_publicacao.jpeg",
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 155, left: 10, bottom: 10),
                    child: Stack(
                      children: [
                        Container(
                          width:200,
                          child: Text(
                            this.publicacao.titulo.length > 19 ?
                              this.publicacao.titulo.substring(0, 22)+'..' :
                              this.publicacao.titulo,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Cores.secundaria()
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35),
                          child: Row(
                            children: [
                              Icon(
                                Icons.attach_money_outlined,
                                size: 15,
                                color: Cores.rosa()
                              ),
                              Text(
                                this.publicacao.custo.toString()+' kz/d',
                                style: TextStyle(
                                  color: Cores.secundaria(),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 35, left: 125),
                          child: Row(
                            children: [
                              Icon(
                                Icons.app_registration,
                                size: 15,
                                color: Cores.rosa()
                              ),
                              Text(
                                (this.publicacao.fimDisponibilidade.toLocal().day.toString()+'/'+this.publicacao.fimDisponibilidade.toLocal().month.toString()+'/'+this.publicacao.fimDisponibilidade.toLocal().year.toString()),
                                style: TextStyle(
                                    color: Cores.secundaria(),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          )
                        ),
                      ],
                    )
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100, left: 150, bottom: 10),
                    child: BotaoIcone(
                      iconData: Icons.add_alert_outlined,
                      onPress: () {
                        this.onAddFavorito( this.publicacao );
                      },
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
