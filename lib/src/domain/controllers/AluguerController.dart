import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:ukubiku/src/apresentacao/widgets/alerta/Snackbar.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/utils/client_http.dart';
import 'package:ukubiku/src/utils/constantes.dart';

class AluguerController extends ClientHttp
{
  BuildContext context;

  AluguerController({required this.context});

  Future<RespostaHttp> salvar( Aluguer item ) async
  {
      try {
        Uri url = Uri.parse( Constantes.ALUGAR );
        Response response = await this.client.post(
            url,
            headers: this.getHeadersAuth(),
            body: jsonEncode( item.toJson() ),
        );

        Map<String, dynamic> data = this.jsonDecode( response.bodyBytes ) as Map<String, dynamic>;
        return this.getResposta( data );
      }
      on HttpException catch( ex ) {
        return RespostaHttp.erro(message:  ex.message );
      }
  }

  Future<List<Aluguer>> lista() async {
    List<Aluguer> lista = List.empty(growable: true);
    try
    {
      Uri url = Uri.parse( Constantes.ALUGAR );
      Response response = await this.client.get( url, headers: this.getHeadersAuth() );
      Map<String, dynamic> data = this.jsonDecode( response.bodyBytes ) as Map<String, dynamic>;

      if ( response.statusCode == HttpStatus.ok )  {
        RespostaHttp respostaHttp = this.getResposta( data );
        lista = Aluguer.fromMap(respostaHttp.data);
      }
      else {
        SnackBarAlerta(
          message: data['message'],
          context: this.context,
          onPress: (){}
        );
      }
    }
    on HttpException catch( ex ) {
      SnackBarAlerta(
          message: ex.message,
          context: this.context,
          onPress: (){}
      );
    }
    return lista;
  }
}