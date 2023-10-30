/// Represents a [RegisterStore]
/// with [id], [cnpj], [name], [autonomyLevelID], [password]

class RegisterStore {
  /// unique indentification
  final int? id;

  /// cnpj
  final int? cnpj;

  /// name
  final String? name;

  /// autonomyLevelID
  final String? autonomyLevelID;

  /// password
  final String? password;

  ///instance of an [RegisterStore]
  /// given  provided [id], [cnpj], [name], [autonomyLevelID],
  /// [password]
  RegisterStore({
    this.id,
    this.cnpj,
    this.name,
    this.autonomyLevelID,
    this.password,
  });
}
