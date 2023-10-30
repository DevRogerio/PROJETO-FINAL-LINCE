// ignore_for_file: avoid_classes_with_only_static_members

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../MODEL/register_store.dart';
import '../MODEL/registration_vehicles.dart';
import '../MODEL/sales.dart';
import '../model/autonomy_level.dart';

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

/// Class for [RegisterStore] table representation
class RegisterStoreTable {
  /// Used on table creation
  static const String createTable = '''
  CREATE TABLE $tableName (
      $id               INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $cnpj             INTEGER NOT NULL,
      $name             TEXT NOT NULL,
      $autonomyLevelID  TEXT NOT NULL,
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

  /// [RegisterStore.autonomyLevelID] column name reference.
  static const String autonomyLevelID = 'autonomyLevelID ';

  /// Inserts the admin user when database is created.
  static const adminUserRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$autonomyLevelID,$password)'
      'VALUES(123,"admin","admin","Anderson")';

  /// Transforms a given [registerStore] into a map.
  static Map<String, dynamic> toMap(RegisterStore registerStore) {
    final map = <String, dynamic>{};

    map[RegisterStoreTable.id] = registerStore.id;
    map[RegisterStoreTable.cnpj] = registerStore.cnpj;
    map[RegisterStoreTable.name] = registerStore.name;
    map[RegisterStoreTable.password] = registerStore.password;
    map[RegisterStoreTable.autonomyLevelID] = registerStore.autonomyLevelID;

    return map;
  }
}

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
          autonomyLevelID: item[RegisterStoreTable.autonomyLevelID],
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

/// Class for [RegistrationTable] table representation
class RegistrationTable {
  /// Used on table creation
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
      $userID         INTEGER NOT NULL
      
    );
  ''';

  /// Table's name reference
  static const String tableName = 'registrationVehicles';

  /// [RegistrationVehicles.id] column name reference.
  static const String id = 'id';

  /// [RegistrationVehicles.model] column name reference.
  static const String model = 'model';

  /// [RegistrationVehicles.plate] column name reference.
  static const String plate = 'plate';

  /// [RegistrationVehicles.brand] column name reference.
  static const String brand = 'brand';

  /// [RegistrationVehicles.builtYear] column name reference.
  static const String builtYear = 'builtYear';

  /// [RegistrationVehicles.vehicleYear] column name reference.
  static const String vehicleYear = 'vehicleYear';

  /// [RegistrationVehicles.photo] column name reference.
  static const String photo = 'photo';

  /// [RegistrationVehicles.pricePaid] column name reference.
  static const String pricePaid = 'pricePaid';

  /// [RegistrationVehicles.purchasedWhen] column name reference.
  static const String purchasedWhen = 'purchasedWhen';

  /// [RegistrationVehicles.userID] column name reference.
  static const String userID = 'userID';

  /// Transforms a given [RegistrationVehicles] into a map
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
    map[RegistrationTable.userID] = registrationVehicles.userID;
    map[RegistrationTable.purchasedWhen] =
        DateFormat('yyyy-MM-dd').format(registrationVehicles.purchasedWhen!);

    return map;
  }
}

/// The controller for [RegistrationTable]
class RegistrationVehiclesController {
  /// Inserts the given [registrationVehicles] into database.
  Future<void> insert(RegistrationVehicles registrationVehicles) async {
    final database = await getDatabase();
    final map = RegistrationTable.toMap(registrationVehicles);

    await database.insert(RegistrationTable.tableName, map);

    return;
  }

  /// Deletes a given [registrationVehicles] from database.
  Future<void> delete(RegistrationVehicles registrationVehicles) async {
    final database = await getDatabase();

    await database.delete(
      RegistrationTable.tableName,
      where: '${RegistrationTable.id} = ?',
      whereArgs: [registrationVehicles.id],
    );
  }

  /// Returns all instances of [RegistrationVehicles]saved on database as a list
  Future<List<RegistrationVehicles>> selectAll() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      RegistrationTable.tableName,
    );

    var list = <RegistrationVehicles>[];

    for (final item in result) {
      list.add(
        RegistrationVehicles(
          id: item[RegistrationTable.id],
          model: item[RegistrationTable.model],
          brand: item[RegistrationTable.brand],
          builtYear: item[RegistrationTable.builtYear],
          purchasedWhen: DateFormat('yyyy-MM-dd')
              .parse(item[RegistrationTable.purchasedWhen]),
          pricePaid: item[RegistrationTable.pricePaid],
          plate: item[RegistrationTable.plate],
          vehiclephoto: item[RegistrationTable.photo],
          vehicleYear: item[RegistrationTable.vehicleYear],
          userID: item[RegistrationTable.userID],
        ),
      );
    }
    return list;
  }

  /// Returns a single [RegistrationVehicles] from database given its [id].
  Future<List<RegistrationVehicles>> selectByCars(int id) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      RegistrationTable.tableName,
      where: '${RegistrationTable.userID} = ?',
      whereArgs: [id],
    );

    var list = <RegistrationVehicles>[];

    for (final item in result) {
      list.add(
        RegistrationVehicles(
          id: item[RegistrationTable.id],
          model: item[RegistrationTable.model],
          brand: item[RegistrationTable.brand],
          builtYear: item[RegistrationTable.builtYear],
          purchasedWhen: DateFormat('yyyy-MM-dd')
              .parse(item[RegistrationTable.purchasedWhen]),
          pricePaid: item[RegistrationTable.pricePaid],
          plate: item[RegistrationTable.plate],
          vehiclephoto: item[RegistrationTable.photo],
          vehicleYear: item[RegistrationTable.vehicleYear],
          userID: item[RegistrationTable.userID],
        ),
      );
    }
    return list;
  }

  /// Updates the given [registrationVehicles] data contained in the database
  Future<void> update(RegistrationVehicles registrationVehicles) async {
    final database = await getDatabase();

    var map = RegistrationTable.toMap(registrationVehicles);

    await database.update(
      RegistrationTable.tableName,
      map,
      where: '${RegistrationTable.id} = ?',
      whereArgs: [registrationVehicles.id],
    );
  }
}

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
      
      $userId         INTEGER NOT NULL
    );
  ''';

  /// Table's name reference
  static const String tableName = 'sale';

  /// [Sale.id] column name reference.
  static const String id = 'id';

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

    map[SalesTable.userId] = sale.userId;

    return map;
  }
}

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

/// AutonomyTable
class AutonomyLeveltable {
  static const String createTable = '''
    CREATE TABLE $tablename(
      $id                 INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $personid           INTEGER NOT NULL,
      $name               TEXT NOT NULL,
      $networkPercentage  REAL NOT NULL,
      $networkSecurity    REAL NOT NULL,
      $storePercentage    REAL NOT NULL 
    );
    ''';

  static const String tablename = 'autonomy_level';

  static const String id = 'id';

  static const String personid = 'id_person';

  static const String name = 'name';

  static const String networkSecurity = 'network_Security';

  static const String storePercentage = 'store_Percentage';

  static const String networkPercentage = 'networkPercentage';

  static Map<String, dynamic> tomap(AutonomyLevel autonomylavel) {
    final map = <String, dynamic>{};

    map[AutonomyLeveltable.id] = autonomylavel.id;
    map[AutonomyLeveltable.personid] = autonomylavel.personID;
    map[AutonomyLeveltable.name] = autonomylavel.name;
    map[AutonomyLeveltable.networkPercentage] = autonomylavel.networkPercentage;
    map[AutonomyLeveltable.networkSecurity] = autonomylavel.networkSecurity;
    map[AutonomyLeveltable.storePercentage] = autonomylavel.storePercentage;

    return map;
  }
}

///autonomy table controller
class AutonomyControler {
  Future<void> insert(
    AutonomyLevel autonomy,
  ) async {
    final database = await getDatabase();
    final map = AutonomyLeveltable.tomap(autonomy);
    await database.insert(AutonomyLeveltable.tablename, map);
  }

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

  Future<void> delete(AutonomyLevel autonomy) async {
    final database = await getDatabase();
    await database.delete(AutonomyLeveltable.tablename,
        where: '${AutonomyLeveltable.id} = ?', whereArgs: [autonomy.id]);
  }

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
