import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/imagem_perfil.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/cores.dart';

class CardAgenciaTurismo extends StatelessWidget
{
  Proprietario proprietario = Proprietario.nova();
  bool loading              = true;

  CardAgenciaTurismo({Proprietario? proprietario})
  {
    if ( proprietario != null ) {
      this.loading    = false;
      this.proprietario = proprietario;
      print( this.proprietario.rhPessoaId.nome );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 2.5, left: 10),
                  child: ImagemPerfil(
                    width:  50,
                    height: 50,
                    onTap: () {},
                  ),
                ),
                Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    margin: EdgeInsets.only(left: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TituloPrimario(
                          this.loading ? "A Carregar..." : this.proprietario.rhPessoaId.nome,
                          fontSize: 17,
                          color: Cores.secundaria(),
                          margin: EdgeInsets.symmetric(vertical: 5),
                        ),
                        TextoDescricao(
                          this.loading ? "A Carregar..." : this.proprietario.rhPessoaId.rh_tipo_pessoa_id.descricao,
                          TextAlign.left,
                          fontSize: 13,
                          margin: EdgeInsets.only(top: 5),
                        )
                      ],
                    )),
                Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(
                    top: 10,
                    right: 10,
                  ),
                  child: BotaoIcone(
                    iconData: Icons.people_outline,
                    background: Cores.primaria(),
                    width: 20,
                    height: 20,
                    sizeIcon: 20,
                    onPress: () {
                      print('');
                    },
                    radius: 30,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            print(new DateTime.now());
          },
        ));
  }
}
