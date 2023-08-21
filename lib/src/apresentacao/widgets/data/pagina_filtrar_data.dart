import 'package:ukubiku/src/data/models/models.dart';

class PaginaFiltrarData {
  late TipoImovel tipoImovel  = TipoImovel.novo();
  late Tipologia tipologia    = Tipologia.novo();
  late double precoMin        = 0;
  late double precoMax        = 0;
  late Cidade cidade          = Cidade.novo();


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map.putIfAbsent("tipo_imovel_id", () => this.tipoImovel.id );
    map.putIfAbsent("tipologia_id", () => this.tipologia.id );
    map.putIfAbsent("cidade_id", () => this.cidade.id );
    map.putIfAbsent("preco_min", () => this.precoMin );
    map.putIfAbsent("preco_max", () => this.precoMax );
    return map;
  }
}