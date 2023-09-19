class RegistrationVehicles {
  final int? id;
  final String model;
  final String plate;
  final String brand;
  final int? builtYear;
  final int? vehicleYear;
  final String? vehiclephoto;
  final double? pricePaid;
  final DateTime? purchasedWhen;
  // final int dealershipId;

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
    // required  this.dealershipId,
  });
}
