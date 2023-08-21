import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/utils/client_http.dart';

import 'dart:convert' as converter;

import 'package:ukubiku/src/utils/constantes.dart';

class GaleriaController extends ClientHttp
{
  GaleriaController(){

  }

  Future<RespostaHttp> getByImovel( int imovelId ) async
  {
    try {
      //
      var url = Uri.parse( Constantes.GALERIA+"/findByImovel/"+imovelId.toString() );
      Response response = await this.client.get(
          url,
          headers: this.getHeadersAuth()
      );
      Map<String, dynamic> data = jsonDecode( response.bodyBytes ) as Map<String, dynamic>;
      return this.getResposta( data );
    }
    on Exception catch(ex)
    {
      RespostaHttp res = RespostaHttp.empty();
      res.message = ex.toString();
      return res;
    }
  }



}