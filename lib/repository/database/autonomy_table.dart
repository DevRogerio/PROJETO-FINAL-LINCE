import '../../entities/autonomy_level.dart';

// ignore: avoid_classes_with_only_static_members
/// AutonomyTable
class AutonomyLeveltable {
  ///create table and pass the variable type
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

  ///table name
  static const String tablename = 'autonomy_level';

  ///autonomy id
  static const String id = 'id';

  ///user id
  static const String personid = 'id_person';

  /// user store name
  static const String name = 'name';

  /// box security
  static const String networkSecurity = 'network_Security';

  /// store commotion
  static const String storePercentage = 'store_Percentage';

  ///affiliate commission
  static const String networkPercentage = 'networkPercentage';

  ///maps the database and assigns the value to the entity
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
