/// Represents a Sale
/// with [id], [cpf], [name], [soldWhen], [priceSold], [dealershipCut],
/// [businessCut], [safetyCut],[userId]
class Sale {
  /// unique indentification
  final int? id;

  /// cpf
  final int? cpf;

  /// name
  final String? name;

  /// soldWhen
  final DateTime? soldWhen;

  /// priceSold
  final double? priceSold;

  /// dealershipCut
  final double? dealershipCut;

  /// businessCut
  final double? businessCut;

  /// safetyCut
  final double? safetyCut;

  /// userId unique for Sale
  final int? userId;

  //final int vehicleid;

  ///instance of an [Sale]
  /// given  provided [id], [cpf], [name], [soldWhen],[priceSold],
  /// [dealershipCut],[businessCut],[safetyCut],[userId]

  Sale({
    this.id,
    this.cpf,
    this.name,
    this.soldWhen,
    this.priceSold,
    this.dealershipCut,
    this.businessCut,
    this.safetyCut,
    this.userId,
    //  required this.vehicleid,
  });
}
