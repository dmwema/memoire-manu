import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  final String label;
  final String hint;
  final int? maxLines;
  final bool password;
  final TextInputType? type;
  final FocusNode? focusNode;
  final bool obscurePassword;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  void Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final void Function()? onPressed;
  bool? enableInteractiveSelection;
  String? initialValue;
  bool readOnly = false;

CustomFormField({
  required this.label,
  required this.hint,
  required this.password,
  this.type,
  this.focusNode,
  this.obscurePassword = false,
  this.suffixIcon,
  this.onFieldSubmitted,
  this.enableInteractiveSelection,
  this.inputFormatters,
  this.controller, this.maxLines, this.onPressed, this.prefixIcon,
  this.initialValue,
  readOnly = false
});

  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus
      ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      keyboardType: type,
      initialValue: initialValue,
      obscureText: obscurePassword,
      focusNode: focusNode,
      enableInteractiveSelection: enableInteractiveSelection,
      maxLines: maxLines,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35)),
        ),
        contentPadding: const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon
      ),
      inputFormatters: inputFormatters,
      onTap: onPressed,
    );
  }
}