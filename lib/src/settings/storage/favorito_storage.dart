import 'package:ukubiku/src/data/models/models.dart';
import 'package:ukubiku/src/settings/storage/local_storage.dart';

class FavoritoStorage
{
  static String IMOVEIS  = "IMOVEIS";


  Future<bool> adicionarImovel( Imovel imovel ) async
  {
    if ( await this.imovelExists(imovel) )
    {
      List<Imovel> lista = await this.listar();
    }
    return false;
  }

  Future<bool> imovelExists( Imovel imovel ) async
  {
    List<Imovel> lista = await this.listar();
    if ( lista.isNotEmpty )
    {
      Imovel item = lista.firstWhere((element) => element.id == imovel.id);
      return item != null;
    }
    return false;
  }

  Future<List<Imovel>> listar() async
  {
    List<Imovel> imoveis = List.empty(growable: true);
    //
    // String resultJson   = await this.get( IMOVEIS );
    // dynamic data = jsonToObject( resultJson );

    return imoveis;
  }

}