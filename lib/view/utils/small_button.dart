import 'package:flutter/material.dart';

/// Button widget
/// with [text], and [onPressed] parameters.
class AppSmallButton extends StatelessWidget {
  /// Constructs an instance of [AppSmallButton] with
  /// the given [text],  and [onPressed] parameters.
  const AppSmallButton({
    super.key,
    this.text,
    required this.onPressed,
  });

  /// callback when button is pressed
  final void Function()? onPressed;

  /// name that appears in the middle of the button
  final String? text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        maximumSize: Size(
          MediaQuery.of(context).size.width / 1.26,
          MediaQuery.of(context).size.height / 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      child: Text(text ?? ''),
    );
  }
}
