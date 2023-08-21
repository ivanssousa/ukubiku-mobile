enum URLS {
  BASE_URL,
  REGISTRAR,
  LOGIN
}

enum RespostasHttp {
  Success, NotFound,ServerError
}

class Constantes
{
  static const DATA_BASE   = 'ukubiku.db';

  static const AUTH_TOKEN  = "api_token";
  static const BASE_URL    = "http://192.168.1.7:17043/";
  //static const BASE_URL    = "http://172.30.42.71:17043/";

  // static const BASE_URL    = "http://ukubiku.herokuapp.com/";
  static const CADASTRAR   = BASE_URL+"auth/cadastrar";
  static const LOGIN       = BASE_URL+"auth/login";

  static const CATEGORIAS  = BASE_URL+"tipoimovel";
  static const IMOVEIS     = BASE_URL+"imoveis";

  static const GALERIA     = BASE_URL+"galeria";
  static const CONTACTOS   = BASE_URL+"contacto";

  static const TIPOLOGIAS   = BASE_URL+"tipologia";

  static const ALUGAR     = BASE_URL+"aluguer";
  static const HOSPEDES   = BASE_URL+"hospede";

  static String CIDADES   = BASE_URL+"provincia";

  static var responseCodes = {
    RespostasHttp.Success: 200,
    RespostasHttp.NotFound: 404,
    RespostasHttp.ServerError: 500
  };
}