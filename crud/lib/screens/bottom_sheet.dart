import 'package:crud/blocs/form_bloc.dart';
import 'package:crud/blocs/form_event.dart';
import 'package:crud/blocs/form_state.dart';
import 'package:crud/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? course;
  final String? year;
  final bool? enrolled;

  const BottomSheetWidget({
    super.key,
    this.id,
    this.firstName,
    this.lastName,
    this.course,
    this.year,
    this.enrolled,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameTextController;
  late TextEditingController lastNameTextController;
  late TextEditingController courseTextController;
  late TextEditingController yearTextController;
  late bool enrolledValue;

  @override
  void initState() {
    super.initState();
    firstNameTextController =
        TextEditingController(text: widget.firstName ?? "");
    lastNameTextController = TextEditingController(text: widget.lastName ?? "");
    courseTextController = TextEditingController(text: widget.course ?? "");
    yearTextController = TextEditingController(text: widget.year ?? "");
    enrolledValue = widget.enrolled ?? false;
  }

  void _handleEnrollmentChange(bool newValue) {
    setState(() {
      enrolledValue = newValue;
    });
  }

  void _addStudent() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<FormBloc>().add(SendData(
            firstNameTextController.text,
            lastNameTextController.text,
            courseTextController.text,
            yearTextController.text,
            enrolledValue,
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  void _updateStudent() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.id != null) {
        context.read<FormBloc>().add(UpdateData(
              widget.id!,
              firstNameTextController.text,
              lastNameTextController.text,
              courseTextController.text,
              yearTextController.text,
              enrolledValue,
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Student ID is missing')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FormBloc, FormsState>(
      listener: (context, state) {
        if (state is FormLoading) {
        } else if (state is FormLoaded) {
          Navigator.pop(context);
        } else if (state is FormError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Server Error")),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      onPressed: () {
                        if ((widget.firstName ?? "").isNotEmpty) {
                          _updateStudent();
                        } else {
                          _addStudent();
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        ((widget.firstName ?? "").isNotEmpty)
                            ? 'Update'
                            : 'Add',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  ((widget.firstName ?? "").isNotEmpty)
                      ? 'Update student'
                      : 'Add student',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                FormWidget(
                  formKey: _formKey,
                  firstNameTextController: firstNameTextController,
                  lastNameTextController: lastNameTextController,
                  courseTextController: courseTextController,
                  yearTextController: yearTextController,
                  enrollmentChange: _handleEnrollmentChange,
                  enrolledValue: enrolledValue,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
