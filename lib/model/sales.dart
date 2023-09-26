class Sale {
  final int id;
  final int cpf;
  final String name;
  final DateTime soldWhen;
  final double priceSold;
  final double dealershipCut;
  final double businessCut;
  final double safetyCut;
  final int vehicleId;
  final int userId;

  Sale({
    required this.id,
    required this.cpf,
    required this.name,
    required this.soldWhen,
    required this.priceSold,
    required this.dealershipCut,
    required this.businessCut,
    required this.safetyCut,
    required this.vehicleId,
    required this.userId,
  });
}
