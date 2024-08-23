import 'package:flutter/material.dart';

enum YearLevelLabel {
  first('First Year'),
  second('Second Year'),
  third('Third Year'),
  fourth('Fourth Year'),
  fifth('Fifth Year');

  const YearLevelLabel(this.label);
  final String label;
}

class DropdownYear extends StatelessWidget {
  final TextEditingController controller;

  const DropdownYear({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DropdownMenu<YearLevelLabel>(
        controller: controller,
        initialSelection: YearLevelLabel.first,
        enableSearch: false,
        requestFocusOnTap: false,
        label: const Text('Year Level'),
        dropdownMenuEntries: YearLevelLabel.values
            .map<DropdownMenuEntry<YearLevelLabel>>((YearLevelLabel year) {
          return DropdownMenuEntry<YearLevelLabel>(
            value: year,
            label: year.label,
          );
        }).toList(),
      ),
    );
  }
}
