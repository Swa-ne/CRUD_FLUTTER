import 'package:crud/widgets/dropdown.dart';
import 'package:crud/widgets/switch.dart';
import 'package:crud/widgets/textfield.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameTextController;
  final TextEditingController lastNameTextController;
  final TextEditingController courseTextController;
  final TextEditingController yearTextController;
  final ValueChanged<bool> enrollmentChange;

  const FormWidget({
    super.key,
    required this.formKey,
    required this.firstNameTextController,
    required this.lastNameTextController,
    required this.courseTextController,
    required this.yearTextController,
    required this.enrollmentChange,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          TextFieldForm(
            prefixText: "First Name: ",
            hintText: "First Name",
            errorText: "Please enter a first name",
            controller: widget.firstNameTextController,
          ),
          const SizedBox(height: 16),
          TextFieldForm(
            prefixText: "Last Name: ",
            hintText: "Last Name",
            errorText: "Please enter a last name",
            controller: widget.lastNameTextController,
          ),
          const SizedBox(height: 16),
          TextFieldForm(
            prefixText: "Course: ",
            hintText: "Course",
            errorText: "Please enter a course",
            controller: widget.courseTextController,
          ),
          const SizedBox(height: 16),
          DropdownYear(controller: widget.yearTextController),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                "Enrolled: ",
                style: TextStyle(fontSize: 20),
              ),
              SwitchEnrolled(
                enrollmentChange: widget.enrollmentChange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
