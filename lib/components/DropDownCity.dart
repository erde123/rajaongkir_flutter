import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownCity extends StatelessWidget {
  final List<String> item;
  final String hintText;
  final String labelText;
  final Function(String?)? onChanged;

  const DropDownCity({
    Key? key,
    required this.item,
    required this.hintText,
    required this.labelText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        showSelectedItems: true,
        disabledItemFn: (String s) => s.startsWith('I'),
        showSearchBox: true,
      ),
      items: item,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
        ),
      ),
      onChanged: onChanged,
      selectedItem: "",
    );
  }
}
