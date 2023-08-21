import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:ukubiku/src/data/models/RespostaHttp.dart';
import 'dart:convert' as converter;

import 'package:ukubiku/src/settings/storage/local_storage.dart';


class ClientHttp
{
  String baseUrl    = "";
  Client client     = new Client();

  LocalStorage storage = LocalStorage.getInstance();

  String getBaseUrl( ) {
    return "";
  }

  getHeadersNoAuth()
  {
    return {
      "content-type": "application/json",
      "charset": 'utf-8'
    };
  }

  getHeadersAuth()
  {
    return {
      "content-type": "application/json",
      "charset": 'utf-8',
      "Authorization": this.storage.getToken()
    };
  }

  dynamic jsonDecode( Uint8List data )
  {
    return converter.jsonDecode( converter.utf8.decode( data ) );
  }

  RespostaHttp getResposta( Map<String, dynamic> resultado )
  {
    return RespostaHttp(
        resultado['message'],
        resultado['status'],
        resultado['code'],
        resultado['data'],
        DateTime.now()
    );
  }
}