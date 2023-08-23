class Sale {
  final int id;
  final int Cpf;
  final String Name;
  final DateTime soldWhen;
  final double priceSold;
  final double dealershipCut;
  final double businessCut;
  final double safetyCut;
  final int vehicleId;
  final int dealershipId;
  final int userId;

  Sale({
    required this.id,
    required this.Cpf,
    required this.Name,
    required this.soldWhen,
    required this.priceSold,
    required this.dealershipCut,
    required this.businessCut,
    required this.safetyCut,
    required this.vehicleId,
    required this.dealershipId,
    required this.userId,
  });
}
