import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

import 'dart:convert' as converter;


class TipoImovelController extends ClientHttp {

  late BuildContext context;

  TipoImovelController({required this.context }) {

  }

  Future<RespostaHttp> listar() async
  {
    try
    {
      var url = Uri.parse( Constantes.CATEGORIAS );
      Response resposta  = await this.client.get( url,  headers: this.getHeadersAuth());

      if ( resposta.statusCode == HttpStatus.ok ) {
        Map<String, dynamic> resultado  = jsonDecode( resposta.bodyBytes ) as Map<String, dynamic>;
        return this.getResposta(resultado);
      }
      return RespostaHttp.erro(
        message: "Desculpe, não foi possível obter tipos de Imoveis"
      );
    }
    catch( ex ){
      return RespostaHttp.erro(message: ex.toString() );
    }
  }
}