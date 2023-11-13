import 'package:intl/intl.dart';

import '../entities/sales.dart';
import '../repository/database/database.dart';
import '../repository/database/sales_table.dart';

/// The controller for [SalesTable]
class SaleController {
  /// Inserts the given [sale] into database.
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    await database.insert(SalesTable.tableName, map);

    return;
  }

  /// Delete the given [sale] into database.
  Future<void> delete(Sale sale) async {
    final database = await getDatabase();

    await database.delete(
      SalesTable.tableName,
      where: '${SalesTable.id} = ?',
      whereArgs: [sale.id],
    );
  }

  /// Returns all instances of [Sale] saved on database as a list.
  Future<List<Sale>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          cpf: item[SalesTable.cpf],
          name: item[SalesTable.name],
          soldWhen: DateFormat('yyyy-MM-dd').parse(item[SalesTable.soldWhen]),
          priceSold: item[SalesTable.priceSold],
          dealershipCut: item[SalesTable.dealershipCut],
          businessCut: item[SalesTable.businessCut],
          safetyCut: item[SalesTable.safetyCut],
          userId: item[SalesTable.userId],
          vehicleid: item[SalesTable.vehicleid],
        ),
      );
    }
    return list;
  }

  /// Returns a single [Sale] from database given its [id].
  Future<List<Sale>> selectByUser(int id) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      SalesTable.tableName,
      where: '${SalesTable.userId} = ?',
      whereArgs: [id],
    );

    var list = <Sale>[];

    for (final item in result) {
      list.add(
        Sale(
          id: item[SalesTable.id],
          cpf: item[SalesTable.cpf],
          name: item[SalesTable.name],
          soldWhen: DateFormat('yyyy-MM-dd').parse(item[SalesTable.soldWhen]),
          priceSold: item[SalesTable.priceSold],
          dealershipCut: item[SalesTable.dealershipCut],
          businessCut: item[SalesTable.businessCut],
          safetyCut: item[SalesTable.safetyCut],
          userId: item[SalesTable.userId],
          vehicleid: item[SalesTable.vehicleid],
        ),
      );
    }
    return list;
  }

  /// Updates the given [sale] data contained in the database
  Future<void> update(Sale sale) async {
    final database = await getDatabase();

    var map = SalesTable.toMap(sale);

    await database.update(
      SalesTable.tableName,
      map,
      where: '${SalesTable.id} = ?',
      whereArgs: [sale.id],
    );
  }
}
