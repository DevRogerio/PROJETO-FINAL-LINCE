// ignore: avoid_classes_with_only_static_members
import 'package:intl/intl.dart';

import '../../entities/sales.dart';

// ignore: avoid_classes_with_only_static_members
/// Class for [SalesTable] table representation
class SalesTable {
  /// Used on table creation
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cpf            INTEGER NOT NULL,
      $name           TEXT NOT NULL,
      $soldWhen       TEXT NOT NULL,
      $priceSold      REAL NOT NULL,
      $dealershipCut  REAL NOT NULL,
      $businessCut    REAL NOT NULL,
      $safetyCut      REAL NOT NULL,
      $vehicleid      INTEGER NOT NULL,
      $userId         INTEGER NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'sale';

  /// [Sale.id] column name reference.
  static const String id = 'id';

  ///[Sale.vehicleid] column name reference.
  static const String vehicleid = 'vehicleid';

  /// [Sale.cpf] column name reference.
  static const String cpf = 'Cpf';

  /// [Sale.name] column name reference.
  static const String name = 'name';

  /// [Sale.soldWhen] column name reference.
  static const String soldWhen = 'soldWhen';

  /// [Sale.priceSold] column name reference.
  static const String priceSold = 'priceSold';

  /// [Sale.dealershipCut] column name reference.
  static const String dealershipCut = 'dealershipCut';

  /// [Sale.businessCut] column name reference.
  static const String businessCut = 'businessCut';

  /// [Sale.safetyCut] column name reference.
  static const String safetyCut = 'safetyCut';

  /// [Sale.userId] column name reference.
  static const String userId = 'userId';

  /// Transforms a given [sale] into a map.
  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[SalesTable.id] = sale.id;
    map[SalesTable.cpf] = sale.cpf;
    map[SalesTable.name] = sale.name;
    map[SalesTable.soldWhen] = DateFormat('yyyy-MM-dd').format(sale.soldWhen!);
    map[SalesTable.priceSold] = sale.priceSold;
    map[SalesTable.dealershipCut] = sale.dealershipCut;
    map[SalesTable.businessCut] = sale.businessCut;
    map[SalesTable.safetyCut] = sale.safetyCut;
    map[SalesTable.vehicleid] = sale.vehicleid;

    map[SalesTable.userId] = sale.userId;

    return map;
  }
}
