import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';

/// autoComplete
///given [suggestions], with [controller],[validator],
/// and [focusNode] parameters.
class AppTextFieldAutoComplete extends StatelessWidget {
  /// Constructs an instance of [AppTextFieldAutoComplete]
  const AppTextFieldAutoComplete({
    required this.suggestions,
    required this.controller,
    this.validator,
    this.focusNode,
    super.key,
  });

  /// List of suggestions
  final List<String> suggestions;

  /// Controls the text typed
  final TextEditingController controller;

  /// Checks whether the typed text is correct
  final String? Function(String?)? validator;

  /// Checks whether widget is being used or not.
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return EasyAutocomplete(
      suggestions: suggestions,
      validator: validator,
      focusNode: focusNode,
      onChanged: (value) => controller,
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
        ),
      ),
    );
  }
}
