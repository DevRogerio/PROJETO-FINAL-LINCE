class Sale {
  final int? id;
  final int? cpf;
  final String? name;
  final DateTime? soldWhen;
  final double? priceSold;
  final double? dealershipCut;
  final double? businessCut;
  final double? safetyCut;
  final int? vehicleId;
  final int? userId;

  Sale({
    this.id,
    this.cpf,
    this.name,
    this.soldWhen,
    this.priceSold,
    this.dealershipCut,
    this.businessCut,
    this.safetyCut,
    this.vehicleId,
    this.userId,
  });
}
