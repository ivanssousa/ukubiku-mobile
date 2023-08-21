import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/utils/cores.dart';


class ModalFiltrar extends StatelessWidget {
  List<String> _codigos  =  List<String>.filled(4, "");

  String _titulo = '';
  String _descricao = '';
  String _labelBotaoVoltar = '';

  Function _event  = (){};
  Function _eventRetry  = (){};

  ModalFiltrar(this._titulo, this._descricao, {Function? submit, Function? eventRetry } ) {

    if ( submit != null )
      this._event = submit;
    if ( eventRetry != null )
      this._eventRetry  = eventRetry;

  }

  @override
  Widget build(BuildContext context) {
    return Flex(direction: Axis.vertical, children: [
      Expanded(
        child: Container(
          margin: EdgeInsets.only(bottom: 0),
          padding: EdgeInsets.only(right: 20, left: 20, top: 30),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                child: TituloPrimario(
                  this._titulo,
                  margin: EdgeInsets.only(bottom: 10),
                  fontSize: 20,
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                width: double.infinity,
                child: TextoDescricao(
                  this._descricao,
                  TextAlign.left,
                  margin: EdgeInsets.only(top: 20, bottom: 50),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Expanded(
                    child: CaixaTexto(
                      "",
                      '',
                      inputType: TextInputType.number,
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      textLimite: 1,
                      getTexto: (String texto) {
                        this._codigos[0]  = texto;
                      },
                    ),
                  ),
                  Expanded(
                    child: CaixaTexto(
                      "",
                      '',
                      inputType: TextInputType.number,
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      textLimite: 1,
                      getTexto: (String texto) {
                        this._codigos[1]  = texto;
                      },
                    ),
                  ),
                  Expanded(
                    child: CaixaTexto(
                      "",
                      '',
                      inputType: TextInputType.number,
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      textLimite: 1,
                      getTexto: (String texto) {
                        this._codigos[2]  = texto;
                      },
                    ),
                  ),
                  Expanded(
                    child: CaixaTexto(
                      "",
                      '',
                      inputType: TextInputType.number,
                      textAlign: TextAlign.center,
                      fontSize: 22,
                      textLimite: 1,
                      getTexto: (String texto) {
                        this._codigos[3]  = texto;
                      },
                    ),
                  ),
                ],
              ),
              Container(
                child: TextoDescricao(
                  "Caso não tenhas recebido o Código Clique Aqui",
                  TextAlign.right,
                  color: Cores.secundaria(),
                  onPress: () {
                    this._eventRetry();
                  },
                ),
                alignment: Alignment.topRight,
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.only(top: 10),
              ),
              Container(
                  margin: EdgeInsets.only(top: 40),
                  child: PrimaryButton("Confirmar Código", () {
                    this._event( this._codigos );
                  }, width: 350)),
            ],
          ),
        ),
      ),
    ]);
  }
}
