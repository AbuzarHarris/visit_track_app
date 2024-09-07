import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

// ignore: must_be_immutable
class SingleDropdownComponent extends StatelessWidget {
  List<String> items;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final String hintText;
  final String labelText;
  final bool enabled;
  final bool showSearchBox;
  String? Function(String?)? validator;
  String? Function(String?)? onChange;
  String? selectedItem;
  SingleDropdownComponent(
      {super.key,
      required this.items,
      this.borderRadius = 0,
      this.borderColor = Constants.textinputColor,
      this.focusedBorderColor = Constants.textinputColor,
      this.contentPadding = const EdgeInsets.symmetric(
        horizontal: 6.0,
        vertical: 6.0,
      ),
      this.hintText = '',
      required this.labelText,
      this.validator,
      this.onChange,
      this.enabled = true,
      this.showSearchBox = false,
      this.selectedItem});

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
          constraints: const BoxConstraints(maxHeight: 200),
          searchFieldProps: const TextFieldProps(
              style: TextStyle(fontSize: 15),
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                  fillColor: Constants.textinputColor,
                  focusColor: Constants.textinputColor,
                  constraints: BoxConstraints(maxHeight: 30),
                  contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Constants.textinputColor)),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Constants.textinputColor)))),
          showSelectedItems: true,
          showSearchBox: showSearchBox,
          listViewProps: const ListViewProps(
            scrollDirection: Axis.vertical,
          ),
          scrollbarProps: const ScrollbarProps(
            interactive: true,
          ),
          menuProps: const MenuProps(
            backgroundColor: Colors.white,
          )),
      items: items,
      enabled: enabled,
      selectedItem: selectedItem,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Constants.textinputColor)),
          constraints: const BoxConstraints(
            maxHeight: 45,
            minHeight: 45,
          ),
          helperStyle: GoogleFonts.raleway(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              letterSpacing: 1),
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 12.0,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Constants.textinputColor),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Constants.textinputColor),
          ),
          labelText: labelText,
          hintText: hintText,
        ),
        // baseStyle: GoogleFonts.raleway(
        //     fontSize: 15,
        //     fontWeight: FontWeight.w500,
        //     color: Colors.grey,
        //     letterSpacing: 1),
      ),
      onChanged: onChange,
      validator: validator,
    );
  }
}
