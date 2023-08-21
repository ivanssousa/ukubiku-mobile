import 'package:flutter/material.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/contacto_page.dart';
import 'package:ukubiku/src/apresentacao/pages/aluguer/hospedes_page.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_back.dart';
import 'package:ukubiku/src/apresentacao/widgets/botao_icone.dart';
import 'package:ukubiku/src/apresentacao/widgets/caixa_texto.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_opcao_aluguer.dart';
import 'package:ukubiku/src/apresentacao/widgets/item_resultado_filtro.dart';
import 'package:ukubiku/src/apresentacao/widgets/models/BotaoModel.dart';
import 'package:ukubiku/src/apresentacao/widgets/primary_button.dart';
import 'package:ukubiku/src/apresentacao/widgets/texto_descricao.dart';
import 'package:ukubiku/src/apresentacao/widgets/titulo_primary.dart';
import 'package:ukubiku/src/utils/cores.dart';

class MetodoPagamentoPage extends StatefulWidget {
  const MetodoPagamentoPage({Key? key}) : super(key: key);

  @override
  _MetodoPagamentoPageState createState() => _MetodoPagamentoPageState();
}

class _MetodoPagamentoPageState extends State<MetodoPagamentoPage> {
  List<String> metodosPagamentos = [
    "Transferência Bancária",
    "Pagamento por Referência",
    "Cartão de Débito"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 50,
          ),
          child: Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Column(
                        children: [
                          Container(
                            child: BotaoBack(
                              BotaoModel(
                                'Voltar',
                                () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.only(top: 0),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: TituloPrimario(
                                    "Metódo de Pagamento",
                                    color: Cores.primaria(),
                                    fontSize: 20,
                                    margin: EdgeInsets.only(
                                      left: 10,
                                      top: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: ItemOpcaoAluguer(
                                    "Aki Paga",
                                    Icon(
                                      Icons.account_balance_outlined,
                                      color: Colors.orange,
                                    ),
                                    Icon(Icons.filter_none),
                                    press: () {},
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ItemOpcaoAluguer(
                                    "Pagamento Por Referência",
                                    Icon(
                                      Icons.transfer_within_a_station_outlined,
                                      color: Colors.deepOrangeAccent,
                                    ),
                                    Icon(Icons.filter_none),
                                    press: () {},
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ItemOpcaoAluguer(
                                    "Cartão de Crédito/Débito",
                                    Icon(Icons.credit_card_outlined),
                                    Icon(Icons.filter_none),
                                    press: () {},
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 0),
                                  child: ItemOpcaoAluguer(
                                    "PayPal",
                                    Icon(
                                      Icons.paypal_outlined,
                                      color: Colors.blueAccent,
                                    ),
                                    Icon(Icons.filter_none),
                                    press: () {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
