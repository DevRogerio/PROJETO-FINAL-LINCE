class RegistrationVehicles {
  final int? id;
  final String model;
  final String? plate;
  final String brand;
  final int? builtYear;
  final int? vehicleYear;
  final String? vehiclephoto;
  final String? pricePaid;
  final String? purchasedWhen;
  final int? dealershipId;

  RegistrationVehicles({
    this.id,
    required this.model,
    required this.brand,
    this.builtYear,
    this.plate,
    this.vehicleYear,
    this.vehiclephoto,
    this.pricePaid,
    this.purchasedWhen,
    this.dealershipId,
  });
}
