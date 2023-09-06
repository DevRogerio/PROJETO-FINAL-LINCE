class RegisterStore {
  final int? id;
  final int cnpj;
  final String name;
  final String? autonomyLevelID;
  final String password;

  RegisterStore({
    this.id,
    required this.cnpj,
    required this.name,
    this.autonomyLevelID,
    required this.password,
  });
}
