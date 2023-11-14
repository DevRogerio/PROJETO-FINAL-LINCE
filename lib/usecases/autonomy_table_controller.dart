import '../entities/autonomy_level.dart';
import '../repository/database/autonomy_table.dart';
import '../repository/database/database.dart';

///autonomy table controller
class AutonomyControler {
  ///insert data into the database in the autonomy table
  Future<void> insert(
    AutonomyLevel autonomy,
  ) async {
    final database = await getDatabase();
    final map = AutonomyLeveltable.tomap(autonomy);
    await database.insert(AutonomyLeveltable.tablename, map);
  }

  /// select all autnonomy table by id
  Future<List<AutonomyLevel>> select(int personID) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
        AutonomyLeveltable.tablename,
        where: '${AutonomyLeveltable.personid} = ?',
        whereArgs: [personID]);

    var list = <AutonomyLevel>[];

    for (var item in result) {
      list.add(AutonomyLevel(
          id: item[AutonomyLeveltable.id],
          personID: item[AutonomyLeveltable.personid],
          name: item[AutonomyLeveltable.name],
          networkSecurity: item[AutonomyLeveltable.networkSecurity],
          storePercentage: item[AutonomyLeveltable.storePercentage],
          networkPercentage: item[AutonomyLeveltable.networkPercentage]));
    }
    return list;
  }

  /// delete autonomy table by id
  Future<void> delete(AutonomyLevel autonomy) async {
    final database = await getDatabase();
    await database.delete(AutonomyLeveltable.tablename,
        where: '${AutonomyLeveltable.id} = ?', whereArgs: [autonomy.id]);
  }

  /// update table by id
  Future<void> update(AutonomyLevel autonomy) async {
    final database = await getDatabase();

    final map = AutonomyLeveltable.tomap(autonomy);

    await database.update(
      AutonomyLeveltable.tablename,
      map,
      where: '${AutonomyLeveltable.id} = ?',
      whereArgs: [autonomy.id],
    );
    return;
  }
}
