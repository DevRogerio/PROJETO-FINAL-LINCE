/// Represents a [AutonomyLevel]
/// with [id], [personID], [name],
///  [networkSecurity], [storePercentage], [networkPercentage]
class AutonomyLevel {
  /// unique indentification
  final int? id;

  /// The ID of the person associated with this autonomy level.
  final int personID;

  /// The name of the autonomy level.
  final String name;

  /// The network security value for this autonomy level.
  final double networkSecurity;

  /// The store percentage value for this autonomy level.
  final double storePercentage;

  /// The network percentage value for this autonomy level.
  final double networkPercentage;

  /// Constructor for creating an AutonomyLevel instance.
  AutonomyLevel({
    this.id,
    required this.name,
    required this.networkSecurity,
    required this.storePercentage,
    required this.networkPercentage,
    required this.personID,
  });
}
