import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/domain/controllers/HospedeController.dart';
import 'package:ukubiku/src/utils/cores.dart';

class HospedePage extends StatefulWidget
{
  late Function onSave;
  HospedeController _hospedeController = HospedeController();

  HospedePage({Key? key, required this.onSave}) {
  }

  @override
  _HospedePageState createState() => _HospedePageState();
}

class _HospedePageState extends State<HospedePage> {

  late Hospede _hospede;
  late TextEditingController _nomeTextEditController = TextEditingController(text: "");
  late TextEditingController _identificacaoTextEditController = TextEditingController(text: "");
  late TextEditingController _telefoneTextEditController = TextEditingController(text: "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this._hospede = Hospede.novo();
  }

  @override
  void didUpdateWidget(covariant HospedePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Container(
                child: Stack(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      color: Cores.primaria(),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            height: 300,
                            alignment: Alignment.topLeft,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      child: BotaoBack(
                        BotaoModel(
                          'Voltar',
                          () {
                            Navigator.pop(context);
                          },
                        ),
                        cor: Cores.branco(),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 70,
                        horizontal: 20,
                      ),
                      child: TituloPrimario(
                        "Dados dos Hospedes",
                        color: Cores.branco(),
                        fontSize: 20,
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: 5,
                            left: 20,
                            right: 20,
                            top: 150,
                          ),
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 40,
                                      ),
                                      child: CaixaTexto(
                                        "Nome Completo",
                                        "",
                                        enabled: false,
                                        readOnly: false,
                                        prefixIcon: Icon(Icons.person_outline),
                                        controller: this._nomeTextEditController,
                                        getTexto: (String value) {
                                          this._hospede.nome = value;
                                        },
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 5,
                                          ),
                                          child: CaixaTexto(
                                            "Nº de Identificação",
                                            "",
                                            enabled: false,
                                            readOnly: false,
                                            textAlign: TextAlign.left,
                                            prefixIcon: Icon(Icons.perm_identity_outlined),
                                            controller: this._identificacaoTextEditController,
                                            getTexto: (String value) {
                                              this._hospede.identificacao = value;
                                            },
                                          ),
                                          alignment: Alignment.topLeft,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 0,
                                      ),
                                      child: CaixaTexto(
                                        "Telefone",
                                        "",
                                        enabled: false,
                                        readOnly: false,
                                        prefixIcon: Icon(Icons.phone_outlined),
                                        controller: this._telefoneTextEditController,
                                        getTexto: (String value) {
                                          this._hospede.telefone = value;
                                        },
                                      ),
                                      alignment: Alignment.topLeft,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 20),
                                      margin: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: PrimaryButton(
                                        "Salvar",
                                        () {
                                          this._adicionar();
                                        },
                                        width: double.infinity,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 40,
                              ),
                              child: Icon(
                                Icons.arrow_circle_down_sharp,
                                color: Colors.black26,
                                size: 40,
                              )),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 40,
                            ),
                            child: TextoDescricao(
                              "Iremos enviar a confirmação para o contacto fornecido acima, este será utilizado também para conbranças.",
                              TextAlign.center,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _adicionar()
  {
    if ( this._hospede.nome.length < 1 )
    {
      SnackBarAlerta(
        message:  "Nome deve ser preenchido.",
        context:  this.context,
        onPress:  (){
        }
      ).show();
      return;
    }
    else if ( this._hospede.identificacao.length < 1 ) {
      SnackBarAlerta(
          message:  "Nº de identificação deve ser preenchido.",
          context:  this.context,
          onPress:  (){
          }
      ).show();
      return;
    }
    if ( this._hospede.telefone.length < 1 ) {
      SnackBarAlerta(
          message:  "Telefone deve ser preenchido.",
          context:  this.context,
          onPress:  (){
          }
      ).show();
      return;
    }
    this.widget.onSave( this._hospede );
    this._hospede = Hospede.novo();
    //Navigator.pop(context);
  }
}
