// ignore: avoid_classes_with_only_static_members, public_member_api_docs
class FormValidator {
  ///method to validate
  static String? validateEmpty(String? value, int maxlength) {
    if (value == null || value.isEmpty) {
      return 'Este campo é obrigatório.';
    } else if (value.length > maxlength) {
      return 'Esse campo deve conter no maximo $maxlength caracteres ';
    }
    return null;
  }
}
