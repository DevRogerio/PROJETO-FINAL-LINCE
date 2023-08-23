import 'package:carros_car/MODEL/RegistrationVehicles.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final path = join(
    await getDatabasesPath(),
    'RegistrarionVehicles.db',
  );

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(RegistrationTable.createTable);
    },
    version: 1,
  );
}

class RegistrationTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id             INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $model          TEXT NOT NULL,
      $plate          TEXT NOT NULL,
      $brand          TEXT NOT NULL,
      $builtYear      INTEGER NOT NULL,
      $vehicleYear    INTEGER NOT NULL,
      $photo          TEXT NOT NULL,
      $pricePaid      REAL NOT NULL,
      $purchasedWhen  TEXT NOT NULL,
      $dealershipId   INTEGER NOT NULL
    );
  ''';

  static const String tableName = 'registrationVehicles';
  static const String id = 'id';
  static const String model = 'model';
  static const String plate = 'plate';
  static const String brand = 'brand';
  static const String builtYear = 'builtYear';
  static const String vehicleYear = 'modelYear';
  static const String photo = 'photo';
  static const String pricePaid = 'pricePaid';
  static const String purchasedWhen = 'purchasedWhen';
  static const String dealershipId = 'dealershipId';

  static Map<String, dynamic> toMap(RegistrationVehicles registrationVehicles) {
    final map = <String, dynamic>{};

    map[RegistrationTable.id] = registrationVehicles.id;
    map[RegistrationTable.model] = registrationVehicles.model;
    map[RegistrationTable.plate] = registrationVehicles.plate;
    map[RegistrationTable.brand] = registrationVehicles.brand;
    map[RegistrationTable.builtYear] = registrationVehicles.builtYear;
    map[RegistrationTable.vehicleYear] = registrationVehicles.vehicleYear;
    map[RegistrationTable.photo] = registrationVehicles.vehiclephoto;
    map[RegistrationTable.pricePaid] = registrationVehicles.pricePaid;
    map[RegistrationTable.purchasedWhen] = registrationVehicles.purchasedWhen;
    map[RegistrationTable.dealershipId] = registrationVehicles.dealershipId;

    return map;
  }
}

class RegistrationVehiclesController {
  Future<void> insert(RegistrationVehicles registrationVehicles) async {
    final database = await getDatabase();
    final map = RegistrationTable.toMap(registrationVehicles);

    await database.insert(RegistrationTable.tableName, map);

    return;
  }
}
