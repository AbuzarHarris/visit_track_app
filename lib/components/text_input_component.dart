import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

// ignore: must_be_immutable
class TextInputComponent extends StatelessWidget {
  final TextEditingController controller;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final int? maxLength;
  final bool autofocus;
  final bool readOnly;
  String? Function(String?)? validator;
  final TextStyle labelStyle;
  final TextStyle floatingLabelStyle;
  final TextInputType keyboardType;
  Function(String?)? onInput;

  TextInputComponent(
      {super.key,
      required this.controller,
      this.borderRadius = 0,
      this.borderColor = Colors.grey,
      this.focusedBorderColor = Constants.primaryColor,
      this.contentPadding = const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 6.0,
      ),
      this.hintText = '',
      this.maxLength,
      this.autofocus = false,
      this.validator,
      this.readOnly = false,
      this.labelStyle = const TextStyle(fontSize: 13),
      this.floatingLabelStyle = const TextStyle(
          fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
      this.keyboardType = TextInputType.text,
      this.onInput});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autofocus: autofocus,
        maxLength: maxLength,
        readOnly: readOnly,
        keyboardType: keyboardType,
        onChanged: (value) => {
              if (onInput != null) {onInput!(value)}
            },
        decoration: InputDecoration(
            isDense: true,
            floatingLabelStyle: floatingLabelStyle,
            labelStyle: labelStyle,
            contentPadding: contentPadding,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: focusedBorderColor,
              ),
            ),
            labelText: hintText),
        validator: validator);
  }
}
