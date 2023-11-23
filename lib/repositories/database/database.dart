// ignore_for_file: avoid_classes_with_only_static_members
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'autonomy_table.dart';
import 'register_store_table.dart';
import 'registration_vehicle_table.dart';
import 'sales_table.dart';

/// initial db
Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'registros.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(RegisterStoreTable.createTable);
      await db.execute(RegistrationTable.createTable);
      await db.execute(SalesTable.createTable);
      await db.execute(AutonomyLeveltable.createTable);
      await db.rawInsert(RegisterStoreTable.adminUserRawInsert);
    },
    version: 2,
  );
}
