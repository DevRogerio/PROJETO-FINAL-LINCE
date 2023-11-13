// Class for [RegistrationTable] table representation
// ignore_for_file: avoid_classes_with_only_static_members
import 'package:intl/intl.dart';
import '../../entities/registration_vehicles.dart';

/// the data base table for [RegistrationVehicles]
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
