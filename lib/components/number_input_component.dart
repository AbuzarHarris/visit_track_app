import 'package:flutter/material.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

// ignore: must_be_immutable
class NumberInputComponent extends StatelessWidget {
  final TextEditingController controller;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final int? maxLength;
  final bool autofocus;
  String? Function(String?)? validator;

  NumberInputComponent({
    super.key,
    required this.controller,
    this.borderRadius = 0,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = Colors.green,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 8.0,
      vertical: 8.0,
    ),
    this.hintText = '',
    this.maxLength,
    this.autofocus = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autofocus: autofocus,
        maxLength: maxLength,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: contentPadding,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Constants.primaryColor,
              ),
            ),
            labelText: hintText),
        validator: validator);
  }
}
