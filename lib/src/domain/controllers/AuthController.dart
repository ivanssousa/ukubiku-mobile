import 'dart:convert' as converter;
import 'dart:io';

import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

class AuthController extends ClientHttp
{

  AuthController() {
  }

  Future<RespostaHttp> cadastrar ( Map<String, dynamic> params ) async {
    var url                 = Uri.parse( Constantes.CADASTRAR );
    Response response       = await this.client.post(
        url,
        body: converter.jsonEncode( params ),
        headers: this.getHeadersNoAuth()
    );
    Map<String, dynamic> resultado  = jsonDecode( response.bodyBytes ) as Map<String, dynamic>;
    return this.getResposta(resultado);
  }

  Future<RespostaHttp> login ( Map<String, dynamic> params ) async {
    try
    {
      var url                 = Uri.parse( Constantes.LOGIN );
      Response response       = await this.client.post(
          url,
          body: converter.jsonEncode( params ),
          headers: this.getHeadersNoAuth()
      );
      Map<String, dynamic> resultado  = jsonDecode( response.bodyBytes ) as Map<String, dynamic>;
      return this.getResposta(resultado);
    }
    on Exception catch(e) {
      print( e );
      return RespostaHttp.empty();
    }
  }

  Future<User> user() async
  {
    try
    {
      Uri url = Uri.parse(Constantes.BASE_URL+"user");
      Response response = await this.client.get(
        url,
        headers: this.getHeadersAuth()
      );

      if ( response.statusCode == HttpStatus.ok ) {
        Map<String, dynamic> data = this.jsonDecode( response.bodyBytes ) as Map<String, dynamic>;
        RespostaHttp respostaHttp = this.getResposta(data);
        return await User.fromJson( respostaHttp.data );
      }
      else {
        throw new Exception("Não foi possível obter o usuário.");
      }
    }
    catch ( ex ) {
      throw ex;
    }
  }
}