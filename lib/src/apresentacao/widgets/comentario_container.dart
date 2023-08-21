import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/imagem_perfil.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/utils/cores.dart';

class Comentario extends StatelessWidget {
  const Comentario({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(top: 2.5, left: 0),
            child: ImagemPerfil(
              width: 50,
              height: 50,
              onTap: () {},
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.only(left: 65),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TituloPrimario(
                  "António",
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Cores.secundaria(),
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                TextoDescricao(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore.",
                  TextAlign.left,
                  fontSize: 12,
                  margin: EdgeInsets.only(top: 0),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ComentarioContainer extends StatelessWidget {
  const ComentarioContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TituloPrimario(
              "Comentários",
              fontSize: 18,
              color: Cores.secundaria(),
              textAlign: TextAlign.start,
              margin: EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.zero,
            child: ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Comentario(),
            ),
          )
        ],
      ),
    );
  }
}
