import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final bool autoFocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;
  final IconData? icon;

  const InputField({
    super.key,
    required this.labelText,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.autoFocus = false,
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon) : null,
        labelText: labelText,
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
