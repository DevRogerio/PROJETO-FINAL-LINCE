import 'package:intl/intl.dart';
import '../../entities/registration_vehicles.dart';
import '../database/database.dart';
import '../database/registration_vehicle_table.dart';

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
