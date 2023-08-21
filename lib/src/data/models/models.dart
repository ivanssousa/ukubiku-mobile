import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ukubiku/src/utils/DateUtil.dart';

class Cidade {
  late int id;
  late String denominacao;

  Cidade(this.id, this.denominacao);

  Cidade.novo() {
    this.id = 0;
    this.denominacao = "";
  }

  static List<Cidade> fromMap(dynamic data) {
    List<Cidade> list = List.empty(growable: true);
    for (Map<String, dynamic> item in data) {
      list.add(Cidade(item['id'], item['descricao']));
    }
    return list;
  }

  Map toJson() => {'id': this.id, 'descricao': this.denominacao};

  @override
  String toString() {
    // TODO: implement toString
    return this.denominacao;
  }
}

// Recursos Humanos
class TipoPessoa {
  int id;
  String descricao;
  String codigo;

  TipoPessoa(this.id, this.descricao, this.codigo);

  factory TipoPessoa.fromJson(dynamic json) {
    return TipoPessoa(json['id'], json['descricao'], json['codigo']);
  }

  Map toJson() =>
      {'id': this.id, 'descricao': this.descricao, 'codigo': this.codigo};
}

@JsonSerializable()
class Pessoa {
  int id = 0;
  TipoPessoa rh_tipo_pessoa_id = new TipoPessoa(0, "", "");
  String n_identificacao = "";
  String nome = "";
  DateTime data_nascimento = DateTime.now();
  int naturalidade = 0;

  Pessoa.nova() {}

  factory Pessoa.fromJson(dynamic json) {
    Pessoa item = Pessoa.nova();
    item.id = json['id'];
    item.n_identificacao = json['nidentificacao'];
    item.nome = json['nome'];

    if (json['dataNascimento'] == null)
      item.data_nascimento = DateTime.now();
    else
      item.data_nascimento = DateTime.parse(json['dataNascimento']);
    item.rh_tipo_pessoa_id = TipoPessoa.fromJson(json['rhTipoPessoaId']);

    return item;
  }

  Pessoa(this.id, this.rh_tipo_pessoa_id, this.n_identificacao, this.nome,
      this.data_nascimento, this.naturalidade);
}

class Contacto {
  int id = 0;
  String contacto = "";
  Pessoa rh_pessoa_id = Pessoa.nova();
  String tipo = "";

  Contacto.novo() {}

  Contacto(this.id, this.contacto, this.rh_pessoa_id, this.tipo);

  static List<Contacto> fromJsonList(dynamic data) {
    List<Contacto> lista = List.empty(growable: true);
    for (dynamic item in data) {
      Contacto contacto = Contacto.novo();
      contacto.id = item['id'];
      contacto.contacto = item['contacto'];
      contacto.tipo = item['tipo'];

      lista.add(contacto);
    }
    return lista;
  }
}

//Segurança
class Role {
  int id;
  String descricao;
  String codigo;
  String home_page;

  Role(this.id, this.descricao, this.codigo, this.home_page);

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'descricao': this.descricao,
        'codigo': this.codigo,
        'home_page': this.home_page
      };
}

class User {
  int id = 0;
  Pessoa rh_pessoa_id = Pessoa.nova();
  String username = "";
  String email = "";
  String telefone = "";
  String password = "";
  String name = "";
  DateTime email_verified_at = DateTime.now();
  DateTime telefone_verified_at = DateTime.now();

  User.novo() {}

  User(this.id, this.rh_pessoa_id, this.username, this.email, this.password,
      this.name, this.email_verified_at, this.telefone_verified_at);

  Map<String, dynamic> toMap() {
    HashMap<String, dynamic> map = new HashMap();
    map.putIfAbsent("username", () => this.username);
    map.putIfAbsent("password", () => this.password);
    map.putIfAbsent("email", () => this.email);
    map.putIfAbsent("telefone", () => this.telefone);
    map.putIfAbsent("name", () => this.name);
    map.putIfAbsent(
        "email_verified_at", () => this.email_verified_at.toString());
    map.putIfAbsent(
        "telefone_verified_at", () => this.telefone_verified_at.toString());
    return map;
  }

  factory User.fromJson(Map<String, dynamic> data) {
    User user = User.novo();

    user.id = data['id'];
    user.telefone = data['telefone'];
    user.username = data['username'];
    user.name = data['name'];
    user.email = data['email'];
    user.rh_pessoa_id = Pessoa.fromJson(data['rhPessoaId']);

    return user;
  }
}

class ChaveConfirmacao {
  int id;
  String chave;
  DateTime created_at;
  DateTime expire_at;
  User users_id;
  String estado;

  ChaveConfirmacao(this.id, this.chave, this.created_at, this.expire_at,
      this.users_id, this.estado);
}

class HistoricoAcesso {
  DateTime horario;
  User user_id;
  String device;

  HistoricoAcesso(this.horario, this.user_id, this.device);
}

class UserRole {
  int id;
  User users_id;
  Role seg_role_id;
  bool is_active;

  UserRole(this.id, this.users_id, this.seg_role_id, this.is_active);
}

class TipoImovel {
  int id;
  String descricao;
  String codigo;

  TipoImovel(this.id, this.descricao, this.codigo);

  factory TipoImovel.novo() {
    return TipoImovel(0, "", "");
  }

  factory TipoImovel.fromJson(dynamic json) {
    return TipoImovel(json['id'], json['descricao'], json['codigo']);
  }
  static List<TipoImovel> mapFromList(dynamic data) {
    List<TipoImovel> list = new List.empty(growable: true);
    for (dynamic item in data) {
      // print( item );
      list.add(TipoImovel.fromJson(item));
    }
    return list;
  }

  Map toJson() => {'id': id, 'descricao': descricao, 'codigo': codigo};

  @override
  String toString() {
    // TODO: implement toString
    return this.descricao;
  }
}

class Tipologia {
  late int id;
  late String descricao;
  late String codigo;

  Tipologia(
      {required this.id, required this.descricao, required this.codigo}) {}

  Tipologia.novo() {
    this.id = 0;
    this.descricao = "";
    this.codigo = "";
  }

  static List<Tipologia> fromMap(dynamic data) {
    List<Tipologia> lista = List.empty(growable: true);
    for (Map<String, dynamic> item in data) {
      lista.add(Tipologia(
          id: item['id'],
          descricao: item['descricao'],
          codigo: item['codigo']));
    }
    return lista;
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.descricao;
  }
}

class Imovel {
  int id = 0;
  String titulo = '';
  String descricao = '';
  DateTime inicioDisponibilidade = DateTime.now();
  DateTime fimDisponibilidade = DateTime.now();
  double custo = 0.0;
  String estado = '';
  late TipoImovel opTipoImovelId;

  String getDataInicio() {
    return this.inicioDisponibilidade.day.toString() +
        "/" +
        this.inicioDisponibilidade.month.toString();
  }

  String getDataFinal() {
    return this.fimDisponibilidade.day.toString() +
        "/" +
        this.fimDisponibilidade.month.toString();
  }

  Imovel.empty() {}

  Imovel(this.id, this.titulo, this.descricao, this.inicioDisponibilidade,
      this.fimDisponibilidade, this.custo, this.estado);

  factory Imovel.fromJson(dynamic json) {
    Imovel item = Imovel(
        json['id'],
        json['titulo'],
        json['descricao'],
        DateTime.parse(json['inicioDisponibilidade']),
        DateTime.parse(json['fimDisponibilidade']),
        json['custo'],
        json['estado']);
    item.opTipoImovelId = TipoImovel.fromJson(json['opTipoImovelId']);
    return item;
  }

  static List<Imovel> mapFromList(dynamic data) {
    List<Imovel> list = new List.empty(growable: true);
    for (dynamic item in data) {
      // print( item );
      list.add(Imovel.fromJson(item));
    }
    return list;
  }

  Map toJson() => {
        'id': id,
        'titulo': titulo,
        'descricao': descricao,
        'inicioDisponibilidade': inicioDisponibilidade.toString(),
        'fimDisponibilidade': fimDisponibilidade.toString(),
        'custo': custo,
        'opTipoImovelId': opTipoImovelId.toString()
      };
}

class Proprietario {
  int id = 0;
  Pessoa rhPessoaId = Pessoa.nova();
  String nproprietario = "";

  Proprietario(this.id, this.rhPessoaId, this.nproprietario);

  Proprietario.nova() {}

  factory Proprietario.fromData(dynamic data) {
    Proprietario item = Proprietario.nova();
    item.id = data['id'];
    item.nproprietario = data['nproprietario'];
    return item;
  }
}

@JsonSerializable()
class Cliente {
  int id = 0;
  Pessoa rhPessoaId = Pessoa.nova();
  String ncliente = "";

  Cliente(this.id, this.rhPessoaId, this.ncliente);

  Cliente.nova() {}

  factory Cliente.fromJson(dynamic data) {
    Cliente item = Cliente.nova();
    item.id = data['id'];
    item.ncliente = data['ncliente'];
    return item;
  }
}

class EstadoAluguer {
  late int id;
  late String descricao;
  late String codigo;

  EstadoAluguer() {
    this.id = 0;
    this.descricao = "";
    this.codigo = "";
  }

  factory EstadoAluguer.fromJson(dynamic json) {
    EstadoAluguer estadoAluguer = EstadoAluguer();
    estadoAluguer.id = json['id'];
    estadoAluguer.descricao = json['descricao'];
    estadoAluguer.codigo = json['codigo'];
    return estadoAluguer;
  }

  Map toJson() =>
      {'id': this.id, 'descricao': this.descricao, 'codigo': this.codigo};
}

class Aluguer {
  late int id;
  late Cliente cliente;
  late Imovel imovel;
  late EstadoAluguer estadoAluguerId;
  late double custoAluguer = 0;
  late DateTime createdAt, horarioInicial, horarioFinal;
  late double tempoEstadia;
  late List<Hospede> hospedes = List.empty(growable: true);
  late DateTime dataMarcacao;

  Aluguer(
      this.id,
      this.cliente,
      this.imovel,
      this.estadoAluguerId,
      this.tempoEstadia,
      this.horarioInicial,
      this.horarioFinal,
      this.createdAt) {}

  factory Aluguer.fromJson(dynamic json) {
    Aluguer aluguer = Aluguer.nova();

    aluguer.id = json['id'];
    aluguer.imovel = Imovel.fromJson(json['opPublicacaoId']);
    aluguer.cliente = Cliente.fromJson(json['opClienteId']);
    aluguer.estadoAluguerId = EstadoAluguer.fromJson(json['estadoAluguerId']);

    aluguer.tempoEstadia = json['tempoEstadia'];
    aluguer.horarioInicial = DateTime.parse(json['horarioInicio']);
    aluguer.horarioFinal = DateTime.parse(json['horarioFinal']);
    aluguer.custoAluguer = json['custoAluguer'];

    aluguer.hospedes = List.empty(growable: true);

    return aluguer;
  }

  Aluguer.nova() {
    this.id = 0;
    this.cliente = Cliente.nova();
    this.dataMarcacao = DateTime.now();
    this.estadoAluguerId = EstadoAluguer();
    this.tempoEstadia = 0;

    this.hospedes = List.empty(growable: true);
  }

  String get getHorarioInicial {
    return this.horarioInicial.day.toString() +
        "/" +
        this.horarioInicial.month.toString() +
        "/" +
        this.horarioInicial.year.toString();
  }

  String get getHorarioFinal {
    return this.horarioFinal.day.toString() +
        "/" +
        this.horarioFinal.month.toString() +
        "/" +
        this.horarioFinal.year.toString();
  }

  int get totalDiasEstadia {
    return this.horarioFinal.difference(this.horarioInicial).inDays;
  }

  int get totalHospedes {
    return this.hospedes.toSet().length;
  }

  double get custoTotal {
    return this.imovel.custo * this.totalDiasEstadia;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();

    if (this.id != null) map.putIfAbsent("id", () => this.id);
    if (this.cliente != null)
      map.putIfAbsent("cliente_id", () => this.cliente.id);
    if (this.imovel != null) map.putIfAbsent("imovel_id", () => this.imovel.id);
    if (this.estadoAluguerId != null)
      map.putIfAbsent("estado_aluguer_id", () => this.estadoAluguerId.id);
    if (this.tempoEstadia != null)
      map.putIfAbsent("tempo_estadia", () => this.tempoEstadia.toString());
    if (this.horarioInicial != null)
      map.putIfAbsent("horario_inicial", () => this.horarioInicial.toString());
    if (this.horarioFinal != null)
      map.putIfAbsent('horario_final', () => this.horarioFinal.toString());
    return map;
  }

  static List<Aluguer> fromMap(dynamic data) {
    List<Aluguer> items = List.empty(growable: true);
    for (Map item in data) {
      Aluguer aluguer = Aluguer.fromJson(item);
      items.add(aluguer);
    }
    return items;
  }

  Map toJson() => {
        "id": this.id,
        "opClienteId": {},
        "opPublicacaoId": {'id': this.imovel.id},
        "estadoAluguerId": {},
        "horarioInicio": DateUtil.formatDate(this.horarioInicial),
        "horarioFinal": DateUtil.formatDate(this.horarioFinal),
        "tempoEstadia":
            this.horarioFinal.difference(this.horarioInicial).inHours,
        "custoAluguer":
            (this.horarioFinal.difference(this.horarioInicial).inHours *
                this.imovel.custo),
        "createdAt": DateUtil.formatDate(this.dataMarcacao),
        "estado": "Solicitado"
      };

  String formatDate(DateTime d) {
    // return d.toLocal().toString();
    return d.year.toString() +
        '-' +
        (d.month.toString()) +
        "-" +
        d.day.toString();
  }

  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}

class Pais {
  int id = 0;
  String descricao = "";

  Pais() {}

  factory Pais.novo() {
    return Pais();
  }

  factory Pais.fromData(dynamic data) {
    Pais item = Pais();
    item.id = data['id'];
    item.descricao = data['descricao'];
    return item;
  }
}

class Provincia {
  int id = 0;
  String descricao = "";
  Pais grlPaisId = Pais.novo();

  Provincia() {}

  factory Provincia.fromData(dynamic data) {
    Provincia item = Provincia();
    item.id = data['id'];
    item.descricao = data['descricao'];
    return item;
  }
}

class Municipio {
  int id = 0;
  String descricao = "";
  Provincia grlProvinciaId = Provincia();

  Municipio() {}

  factory Municipio.fromData(dynamic json) {
    Municipio item = Municipio();
    item.id = json['id'];
    item.descricao = json['descricao'];
    return item;
  }
}

class Localidade {
  int id = 0;
  String descricao = "";
  Municipio grlMunicipioId = Municipio();

  Localidade() {}

  factory Localidade.fromData(dynamic json) {
    Localidade item = Localidade();
    item.id = json['id'];
    item.descricao = json['descricao'];
    return item;
  }
}

class Endereco {
  int id = 0;
  String endereco = "";
  String lat = "";
  String log = "";
  String referencia = "";
  String telefone = "";
  String email = "";
  Localidade grlLocalidadeId = Localidade();
  Pessoa rhPessoaId = Pessoa.nova();

  Endereco() {}

  Endereco.novo() {}
}

class Residencia {}

class Galeria {
  int id = 0;
  String fileName = "";
  String extension = "";
  int userId = 0;
  String base64 = "";

  factory Galeria.novo() {
    return Galeria();
  }

  Galeria() {}

  factory Galeria.fromJson(dynamic item) {
    Galeria galeria = Galeria();
    galeria.id = item['id'];
    galeria.fileName = item['fileName'];
    galeria.extension = item['extension'];
    galeria.userId = item['userId'];
    galeria.base64 = item['base64'];
    return galeria;
  }

  static List<Galeria> fromJsonList(List<dynamic> data) {
    List<Galeria> items = List.empty(growable: true);
    for (dynamic item in data) {
      Galeria galeria = Galeria.fromJson(item);
      items.add(galeria);
    }
    return items;
  }
}

class Hospede {
  late int id;
  late String nome, identificacao, telefone;
  late Aluguer aluguer;

  Hospede(
      {required this.id,
      required this.nome,
      required this.identificacao,
      required this.telefone,
      required this.aluguer}) {}

  Hospede.novo() {
    this.id = 0;
    this.nome = this.identificacao = this.telefone = "";
    this.aluguer = Aluguer.nova();
  }

  Map toJson() => {
        'id': this.id,
        'nome': this.nome,
        'identificacao': this.identificacao,
        'telefone': this.telefone
      };

  @override
  String toString() {
    // TODO: implement toString
    return "{id: $id, nome: $nome, identificacao: $identificacao, telefone: $telefone}";
  }
}
