import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ukubiku/src/utils/constantes.dart';

class SQLLiteStorage
{
  static Future<Database> ensureDatabaseInitialization() async
  {
    return openDatabase(
        join( await getDatabasesPath(), Constantes.DATA_BASE ),
        onCreate: onCreate,
        version: 1
    );
  }

  static onCreate(Database database, int version)
  {
    return database.execute("create table if not exists acess_token(" +
        "id integer primary key autoincrement," +
        "token varchar(1024) not null," +
        "expire_at datetime not null" +
        ");");
  }
}
