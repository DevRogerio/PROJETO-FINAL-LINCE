import 'package:carros_car/MODEL/RegisterStore.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'registros.db',
  );
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(RegisterStoreTable.createTable);
    },
    version: 1,
  );
}

class RegisterStoreTable {
  static const String createTable = '''
  CREATE TABLE $tableName (
      $id               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj             INTEGER NOT NULL,
      $name             TEXT NOT NULL,
      $autonomyLevelID  TEXT NOT NULL,
      $password         TEXT NOT NULL
    ); 
  ''';

  static const String tableName = 'RegisterStore';
  static const String id = 'id';
  static const String name = 'name';
  static const String cnpj = 'cnpj';
  static const String password = 'password';
  static const String autonomyLevelID = 'autonomyLevelID ';

  static Map<String, dynamic> toMap(RegisterStore registerStore) {
    final map = <String, dynamic>{};

    map[RegisterStoreTable.id] = registerStore.id;
    map[RegisterStoreTable.cnpj] = registerStore.cnpj;
    map[RegisterStoreTable.name] = registerStore.name;
    map[RegisterStoreTable.password] = registerStore.password;
    map[RegisterStoreTable.autonomyLevelID] = registerStore.autonomyLevelID;

    return map;
  }

  insert(RegisterStore registerStore) {}
}

class RegisterController {
  Future<void> insert(RegisterStore registerStore) async {
    final database = await getDatabase();
    final map = RegisterStoreTable.toMap(registerStore);

    await database.insert(RegisterStoreTable.tableName, map);

    return;
  }
}
