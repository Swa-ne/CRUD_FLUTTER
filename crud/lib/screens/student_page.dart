import 'package:crud/blocs/form_bloc.dart';
import 'package:crud/main.dart';
import 'package:crud/models/student.dart';
import 'package:crud/screens/bottom_sheet.dart';
import 'package:crud/services/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentPage extends StatefulWidget {
  final StudentModel student;
  const StudentPage({super.key, required this.student});

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late StudentModel student;
  @override
  void initState() {
    super.initState();
    student = widget.student;
  }

  void _updateStudent(StudentModel updatedStudent) {
    setState(() {
      student = updatedStudent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainApp(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              StudentRepo().deleteStudent(student.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MainApp(),
                ),
              );
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
                    onStudentUpdated: _updateStudent,
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
