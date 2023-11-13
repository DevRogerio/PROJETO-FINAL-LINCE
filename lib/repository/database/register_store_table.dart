import '../../entities/register_store.dart';

// ignore: avoid_classes_with_only_static_members
/// Class for [RegisterStore] table representation
class RegisterStoreTable {
  /// Used on table creation
  static const String createTable = '''
  CREATE TABLE $tableName (
      $id               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj             INTEGER NOT NULL,
      $name             TEXT NOT NULL,
    
      $password         TEXT NOT NULL
    ); 
  ''';

  /// Table's name reference
  static const String tableName = 'RegisterStore';

  /// [RegisterStore.id] column name reference.
  static const String id = 'id';

  /// [RegisterStore.name] column name reference.
  static const String name = 'name';

  /// [RegisterStore.cnpj] column name reference.
  static const String cnpj = 'cnpj';

  /// [RegisterStore.password] column name reference.
  static const String password = 'password';

  /// Inserts the admin user when database is created.
  static const adminUserRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$password)'
      'VALUES(123,"admin","Anderson")';

  /// Transforms a given [registerStore] into a map.
  static Map<String, dynamic> toMap(RegisterStore registerStore) {
    final map = <String, dynamic>{};

    map[RegisterStoreTable.id] = registerStore.id;
    map[RegisterStoreTable.cnpj] = registerStore.cnpj;
    map[RegisterStoreTable.name] = registerStore.name;
    map[RegisterStoreTable.password] = registerStore.password;

    return map;
  }
}
