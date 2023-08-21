import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as converter;

import 'package:ukubiku/src/utils/constantes.dart';


class LocalStorage
{
  static final LocalStorage _localStorage = LocalStorage._internal();
  SharedPreferences? sharedPreferences;

  LocalStorage._internal();

  loadSettings() async  {
    SharedPreferences.setMockInitialValues({});
    _localStorage.sharedPreferences = await SharedPreferences.getInstance();
  }

  static LocalStorage getInstance()
  {
    return _localStorage != null ? _localStorage as LocalStorage : LocalStorage._internal();
  }

  String getToken() {
    return this.sharedPreferences?.getString( Constantes.AUTH_TOKEN ) ?? '';
  }

  Future<bool> setToken( String token ) async {
    return await this.sharedPreferences?.setString( Constantes.AUTH_TOKEN, "Bearer "+token) ?? false;
  }

  Future<bool> set( String key ,String value ) async {
    SharedPreferences _preferences =  await SharedPreferences.getInstance();
    return await _preferences.setString(key, value);
  }

  Future<String> get( String key ) async {
    SharedPreferences _preferences  = await SharedPreferences.getInstance();
    return _preferences.getString( key ) ?? '{}';
  }

  dynamic jsonToObject( String value ) {
    return converter.jsonDecode( value );
  }

  String mapToJson( Object value ) {
    return converter.jsonEncode( value );
  }

}