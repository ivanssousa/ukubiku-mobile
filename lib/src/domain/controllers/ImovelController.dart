import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

import 'dart:convert' as converter;

class ImovelController extends ClientHttp
{
  BuildContext context;
  ImovelController({required this.context}) {
  }

  Future<RespostaHttp> listar() async {
    try {
      var url       = Uri.parse( Constantes.IMOVEIS );
      Response resposta  = await this.client.get(
          url,
          headers: this.getHeadersAuth()
      );
      Map<String, dynamic> resultado  = jsonDecode( resposta.bodyBytes ) as Map<String, dynamic>;
      return this.getResposta(resultado);
    }
    catch ( ex ) {
      return RespostaHttp.erro(message: ex.toString() );
    }
  }

  Future<RespostaHttp> getById( int id ) async
  {
    var url       = Uri.parse( Constantes.IMOVEIS+'/'+id.toString() );
    Response resposta  = await this.client.get(
        url,
        headers: this.getHeadersAuth()
    );
    Map<String, dynamic> resultado  = jsonDecode( resposta.bodyBytes ) as Map<String, dynamic>;
    return this.getResposta(resultado);
  }

  Future<RespostaHttp> getTotalDisponivel( Map<String, dynamic> params ) async {
    var url               = Uri.parse( Constantes.IMOVEIS+"/totalDisponivel" );
    Response httpResponse = await this.client.post( url,
      headers: this.getHeadersAuth(),
      body:  converter.jsonEncode( params )
    );

    Map<String, dynamic> data = jsonDecode( httpResponse.bodyBytes ) as Map<String, dynamic>;
    return this.getResposta( data );
  }
}