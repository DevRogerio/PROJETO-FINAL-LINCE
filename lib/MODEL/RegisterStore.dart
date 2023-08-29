class RegisterStore {
  final int? id;
  final int? cnpj;
  final String name;
  final String? autonomyLevelID;
  final String password;

  RegisterStore({
    this.id,
    this.cnpj,
    required this.name,
    required this.autonomyLevelID,
    required this.password,
  });
}
