import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

class HospedeController extends ClientHttp {

  HospedeController(){

  }


  Future<RespostaHttp> salvar( Hospede item ) async
  {
    try
    {
      Uri url = Uri.parse(Constantes.HOSPEDES);
      Response res = await this.client.post(
        url,
        headers: this.getHeadersAuth(),
        body: item
      );

      Map<String, dynamic> data = jsonDecode( res.bodyBytes ) as Map<String, dynamic>;
      return this.getResposta( data );
    }
    on Exception catch( ex )
    {
      RespostaHttp resposta = RespostaHttp.erro(message: "Não foi possível salvar o hospede.");
      return resposta;
    }
  }
}