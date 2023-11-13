import '../../entities/autonomy_level.dart';

// ignore: avoid_classes_with_only_static_members
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
