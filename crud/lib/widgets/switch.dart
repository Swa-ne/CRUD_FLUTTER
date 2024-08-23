import 'package:flutter/material.dart';

class SwitchEnrolled extends StatefulWidget {
  final ValueChanged<bool> enrollmentChange;
  const SwitchEnrolled({super.key, required this.enrollmentChange});

  @override
  State<SwitchEnrolled> createState() => _SwitchEnrolledState();
}

class _SwitchEnrolledState extends State<SwitchEnrolled> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      activeColor: Colors.red,
      onChanged: (bool newValue) {
        setState(() {
          value = newValue;
        });
        widget.enrollmentChange(newValue); // Notify parent about the change
      },
    );
  }
}
