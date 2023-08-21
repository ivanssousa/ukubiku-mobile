import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

class TipologiaController extends ClientHttp {
  late BuildContext context;
  late Function onPressError;

  TipologiaController({required this.context, Function? onError}) {
    if (onError != null) this.onPressError = onError;
  }

  Future<List<Tipologia>> listar() async {
    try
    {
      Uri url = Uri.parse(Constantes.TIPOLOGIAS);
      Response res = await this.client.get(url, headers: this.getHeadersAuth());
      Map<String, dynamic> resultado =
          this.jsonDecode(res.bodyBytes) as Map<String, dynamic>;
      if (res.statusCode == HttpStatus.ok)
      {
        RespostaHttp resposta = this.getResposta(resultado);
        return Tipologia.fromMap(resposta.data);
      }
      else
      {
        SnackBarErro(
          "Não foi possível listar as tipologias.",
          () {},
          this.context
        ).show();
      }
      return List.empty();
    }
    on HttpException catch (ex) {
      SnackBarErro(
          ex.message.toString(),
          this.onPressError != null
              ? this.onPressError
              : () {
                  print(ex.message);
                },
          this.context
      ).show();
      return List.empty();
    }
  }
}
