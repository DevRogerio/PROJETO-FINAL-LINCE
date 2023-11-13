import '../entities/register_store.dart';
import '../repository/database/database.dart';
import '../repository/database/register_store_table.dart';

/// The controller for [RegisterController]
class RegisterController {
  /// Inserts the given [registerStore] into database.
  Future<void> insert(RegisterStore registerStore) async {
    final database = await getDatabase();
    final map = RegisterStoreTable.toMap(registerStore);

    await database.insert(RegisterStoreTable.tableName, map);

    return;
  }

  /// Deletes a given [registerStore] from database.
  Future<void> delete(RegisterStore registerStore) async {
    final database = await getDatabase();

    await database.delete(
      RegisterStoreTable.tableName,
      where: '${RegisterStoreTable.id} = ?',
      whereArgs: [registerStore.id],
    );
  }

  /// Returns all instances of [RegisterStore] saved on database as a list.
  Future<List<RegisterStore>> select() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      RegisterStoreTable.tableName,
    );

    var list = <RegisterStore>[];

    for (final item in result) {
      list.add(
        RegisterStore(
          id: item[RegisterStoreTable.id],
          cnpj: item[RegisterStoreTable.cnpj],
          name: item[RegisterStoreTable.name],
          password: item[RegisterStoreTable.password],
        ),
      );
    }
    return list;
  }

  /// Updates the given [registerStore] data contained in the database
  Future<void> update(RegisterStore registerStore) async {
    final database = await getDatabase();

    var map = RegisterStoreTable.toMap(registerStore);

    await database.update(
      RegisterStoreTable.tableName,
      map,
      where: '${RegisterStoreTable.id} = ?',
      whereArgs: [registerStore.id],
    );
  }
}
