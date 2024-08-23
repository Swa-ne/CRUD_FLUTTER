import 'package:crud/blocs/form_bloc.dart';
import 'package:crud/models/student.dart';
import 'package:crud/screens/bottom_sheet.dart';
import 'package:crud/services/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentPage extends StatelessWidget {
  final StudentModel student;
  const StudentPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              StudentRepo().deleteStudent(student.id);
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (ctx) => BlocProvider(
                  create: (context) => FormBloc(StudentRepo()),
                  child: BottomSheetWidget(
                    firstName: student.firstName,
                    lastName: student.lastName,
                    course: student.course,
                    year: student.year,
                    enrolled: student.enrolled,
                    id: student.id,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('${student.firstName} ${student.lastName}'),
            Text(student.course),
            Text(student.enrolled ? "Currently Enrolled" : "Not Enrolled")
          ],
        ),
      ),
    );
  }
}
