import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../MODEL/register_store.dart';
import '../MODEL/registration_vehicles.dart';
import '../MODEL/sales.dart';

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
      await db.rawInsert(RegisterStoreTable.adminUserRawInsert);
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
  static const adminUserRawInsert =
      'INSERT INTO $tableName($cnpj,$name,$autonomyLevelID,$password)'
      'VALUES(123,"admin","admin","Anderson")';

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

class RegisterController {
  Future<void> insert(RegisterStore registerStore) async {
    final database = await getDatabase();
    final map = RegisterStoreTable.toMap(registerStore);

    await database.insert(RegisterStoreTable.tableName, map);

    return;
  }

  Future<void> delete(RegisterStore registerStore) async {
    final database = await getDatabase();

    await database.delete(
      RegisterStoreTable.tableName,
      where: '${RegisterStoreTable.id} = ?',
      whereArgs: [registerStore.id],
    );
  }

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
      $userID         INTEGER NOT NULL
      
    );
  ''';

  static const String tableName = 'registrationVehicles';
  static const String id = 'id';
  static const String model = 'model';
  static const String plate = 'plate';
  static const String brand = 'brand';
  static const String builtYear = 'builtYear';
  static const String vehicleYear = 'vehicleYear';
  static const String photo = 'photo';
  static const String pricePaid = 'pricePaid';
  static const String purchasedWhen = 'purchasedWhen';
  static const String userID = 'userID';

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

class RegistrationVehiclesController {
  Future<void> insert(RegistrationVehicles registrationVehicles) async {
    final database = await getDatabase();
    final map = RegistrationTable.toMap(registrationVehicles);

    await database.insert(RegistrationTable.tableName, map);

    return;
  }

  Future<void> delete(RegistrationVehicles registrationVehicles) async {
    final database = await getDatabase();

    await database.delete(
      RegistrationTable.tableName,
      where: '${RegistrationTable.id} = ?',
      whereArgs: [registrationVehicles.id],
    );
  }

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

class SalesTable {
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

  static const String tableName = 'sale';
  static const String id = 'id';
  static const String cpf = 'Cpf';
  static const String name = 'name';
  static const String soldWhen = 'soldWhen';
  static const String priceSold = 'priceSold';
  static const String dealershipCut = 'dealershipCut';
  static const String businessCut = 'businessCut';
  static const String safetyCut = 'safetyCut';

  static const String userId = 'userId';

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

class SaleController {
  Future<void> insert(Sale sale) async {
    final database = await getDatabase();
    final map = SalesTable.toMap(sale);

    await database.insert(SalesTable.tableName, map);

    return;
  }

  Future<void> delete(Sale sale) async {
    final database = await getDatabase();

    await database.delete(
      SalesTable.tableName,
      where: '${SalesTable.id} = ?',
      whereArgs: [sale.id],
    );
  }

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
