import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

class CidadeController extends ClientHttp
{
  BuildContext context;

  CidadeController({required this.context})
  {
  }

  Future<List<Cidade>> listar() async {
    try
    {
      Uri url = Uri.parse( Constantes.CIDADES );
      Response res = await this.client.get(
        url,
        headers: this.getHeadersAuth()
      );

      Map<String, dynamic> data = this.jsonDecode( res.bodyBytes ) as Map<String, dynamic>;
      RespostaHttp resposta     = this.getResposta(data);
      List<Cidade> lista        = Cidade.fromMap( resposta.data );
      return lista;
    }
    on HttpException catch ( ex ) {
      return [];
    }
  }
}