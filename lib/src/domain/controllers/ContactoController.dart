import 'dart:io';

import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/utils/client_http.dart';

import 'dart:convert' as converter;

import 'package:ukubiku/src/utils/constantes.dart';

class ContactoController extends ClientHttp
{
  Future<RespostaHttp> meus() async
  {

      Uri url = Uri.parse( Constantes.CONTACTOS+'/meus');
      Response res = await this.client.get(
          url,
          headers: this.getHeadersAuth()
      );

      Map<String, dynamic> resultado = this.jsonDecode( res.bodyBytes ) as Map<String, dynamic>;
      if ( res.statusCode == HttpStatus.ok  )
        return this.getResposta(resultado);
      else {
        RespostaHttp resposta = RespostaHttp.empty();
        resposta.message = "Desculpe, não foi possível encontrar contactos";
        resposta.status  = res.statusCode;
        resposta.code    = res.statusCode;
        return resposta;
      }

  }
}