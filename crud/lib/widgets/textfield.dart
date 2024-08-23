import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  final String prefixText;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  const TextFieldForm({
    super.key,
    required this.prefixText,
    required this.hintText,
    required this.controller,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        label: Text(prefixText),
        labelStyle: const TextStyle(color: Colors.black),
        hintText: hintText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return errorText;
        }
        return null;
      },
    );
  }
}
