import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:personal_phone_dictionary/utils/constants.dart';

class DatePickerComponent extends StatefulWidget {
  final String label;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final EdgeInsetsGeometry contentPadding;
  final ValueChanged<DateTime> onDateSelected;
  final String format;
  final String hintText;
  final DateTime? inputdate;
  bool readOnly;
  bool showsuffix;
  bool Function(DateTime)? selectableDay;
  DateTime? firstDate = DateTime(2000);
  DateTime? lastDate = DateTime(3000);

  DatePickerComponent(
      {super.key,
      required this.onDateSelected,
      this.label = '',
      this.borderRadius = 4,
      this.borderColor = Constants.textinputColor,
      this.focusedBorderColor = Constants.textinputColor,
      this.contentPadding = const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 12.0,
      ),
      this.format = "dd-MMM-yyyy",
      this.hintText = '',
      this.inputdate,
      this.readOnly = false,
      this.selectableDay,
      this.firstDate,
      this.lastDate,
      this.showsuffix = false});

  @override
  _DatePickerComponentState createState() => _DatePickerComponentState();
}

class _DatePickerComponentState extends State<DatePickerComponent> {
  DateTime? selectedDate;
  bool _readonly = false;
  bool Function(DateTime)? selectableDay;
  DateTime? firstDate;
  DateTime? lastDate;
  @override
  void initState() {
    super.initState();
    selectedDate = widget.inputdate;
    _readonly = widget.readOnly;
    selectableDay = widget.selectableDay;
    firstDate = widget.firstDate;
    lastDate = widget.lastDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? DateTime.now(),
        firstDate: firstDate ?? DateTime(2000),
        lastDate: lastDate ?? DateTime(3000),
        selectableDayPredicate: selectableDay);
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  String get formattedDate {
    if (selectedDate == null) return '';
    return DateFormat(widget.format).format(selectedDate!);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_readonly == false) {
          _selectDate(context);
        } else {}
      },
      child: InputDecorator(
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
            contentPadding: widget.contentPadding,
            border: const OutlineInputBorder(),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Constants.textinputColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.focusedBorderColor,
              ),
            ),
            labelText: selectedDate == null ? "" : widget.hintText,

            //hintText: hintText,
            hintStyle: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                letterSpacing: 1),
            suffixIcon: widget.showsuffix
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        selectedDate = null;
                      });
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 12,
                    ))
                : const Text("")),
        child: Text(
          selectedDate == null ? widget.hintText : formattedDate,
          style: GoogleFonts.raleway(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              letterSpacing: 1),
        ),
      ),
    );
  }
}
