import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../MODEL/sales.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'sales.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(SalesTable.createTable);
    },
    version: 1,
  );
}

class SalesTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $Cpf    INTEGER NOT NULL,
      $Name   TEXT NOT NULL,
      $soldWhen       TEXT NOT NULL,
      $priceSold      REAL NOT NULL,
      $dealershipCut  REAL NOT NULL,
      $businessCut    REAL NOT NULL,
      $safetyCut      REAL NOT NULL,
      $vehicleId      INTERGER NOT NULL,
      $dealershipId   INTEGER NOT NULL,
      $userId         INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'sale';
  static const String id = 'id';
  static const String Cpf = 'Cpf';
  static const String Name = 'Name';
  static const String soldWhen = 'soldWhen';
  static const String priceSold = 'priceSold';
  static const String dealershipCut = 'dealershipCut';
  static const String businessCut = 'businessCut';
  static const String safetyCut = 'safetyCut';
  static const String vehicleId = 'vehicleId';
  static const String dealershipId = 'dealershipId';
  static const String userId = 'userId';

  static Map<String, dynamic> toMap(Sale sale) {
    final map = <String, dynamic>{};

    map[SalesTable.id] = sale.id;
    map[SalesTable.Cpf] = sale.Cpf;
    map[SalesTable.Name] = sale.Name;
    map[SalesTable.soldWhen] = sale.soldWhen;
    map[SalesTable.priceSold] = sale.priceSold;
    map[SalesTable.dealershipCut] = sale.dealershipCut;
    map[SalesTable.businessCut] = sale.businessCut;
    map[SalesTable.safetyCut] = sale.safetyCut;
    map[SalesTable.vehicleId] = sale.vehicleId;
    map[SalesTable.dealershipId] = sale.dealershipId;
    map[SalesTable.userId] = sale.userId;

    return map;
  }
}

class SaleController {
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    await database.insert(SalesTable.tableName, map);

    return;
  }
}
