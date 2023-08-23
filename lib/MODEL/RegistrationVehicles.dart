class RegistrationVehicles {
  final int id;
  final String model;
  final String plate;
  final String brand;
  final int builtYear;
  final int vehicleYear;
  final String vehiclephoto;
  final double pricePaid;
  final DateTime purchasedWhen;
  final int dealershipId;

  RegistrationVehicles({
    required this.id,
    required this.model,
    required this.brand,
    required this.builtYear,
    required this.plate,
    required this.vehicleYear,
    required this.vehiclephoto,
    required this.pricePaid,
    required this.purchasedWhen,
    required this.dealershipId,
  });
}
