import 'package:crud/blocs/form_bloc.dart';
import 'package:crud/blocs/form_event.dart';
import 'package:crud/blocs/form_state.dart';
import 'package:crud/widgets/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameTextController = TextEditingController();
  final TextEditingController lastNameTextController = TextEditingController();
  final TextEditingController courseTextController = TextEditingController();
  final TextEditingController yearTextController = TextEditingController();
  bool enrolledValue = false;

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
                        _addStudent();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                  'Add student',
                  style: TextStyle(
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
