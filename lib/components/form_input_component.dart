import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

// ignore: must_be_immutable
class FormInputComponent extends StatelessWidget {
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

  FormInputComponent(
      {super.key,
      required this.controller,
      this.borderRadius = 0,
      this.borderColor = Constants.textinputColor,
      this.focusedBorderColor = Constants.textinputColor,
      this.contentPadding = const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      this.hintText = '',
      this.maxLength,
      this.autofocus = false,
      this.validator,
      this.readOnly = false,
      this.labelStyle = const TextStyle(fontSize: 14),
      this.floatingLabelStyle = const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.grey),
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      maxLength: maxLength,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        focusColor: Colors.grey[100],
        isDense: true,
        floatingLabelStyle: GoogleFonts.raleway(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            letterSpacing: 1),
        labelStyle: GoogleFonts.raleway(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            letterSpacing: 1),
        contentPadding: contentPadding,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Constants.textinputColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: focusedBorderColor,
          ),
        ),
        labelText: hintText,

        //hintText: hintText,
        hintStyle: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
            letterSpacing: 1),
      ),
      validator: validator,
    );
  }
}
