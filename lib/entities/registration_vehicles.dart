/// Represents a RegistrationVehicles
/// with [id], [model], [plate], [brand], [builtYear], [vehicleYear],
/// [vehiclephoto], [pricePaid], [purchasedWhen],[userID]
class RegistrationVehicles {
  /// unique indentification
  final int? id;

  /// model
  final String model;

  /// plate
  final String plate;

  /// brand
  final String brand;

  /// builtYear
  final int? builtYear;

  /// vehicleYear
  final int? vehicleYear;

  /// vegiclephoto
  final String? vehiclephoto;

  /// pricePaid
  final double? pricePaid;

  /// purchasedWhen
  final DateTime? purchasedWhen;

  /// userID unique for RegistrationVehicles
  final int userID;

  ///instance of an [RegistrationVehicles]
  /// given  provided [id], [model], [brand], [builtYear],[plate],
  /// [vehicleYear],[vehiclephoto],[pricePaid],[purchasedWhen],[userID]

  RegistrationVehicles({
    this.id,
    required this.model,
    required this.brand,
    this.builtYear,
    required this.plate,
    this.vehicleYear,
    this.vehiclephoto,
    this.pricePaid,
    this.purchasedWhen,
    required this.userID,
  });
}
