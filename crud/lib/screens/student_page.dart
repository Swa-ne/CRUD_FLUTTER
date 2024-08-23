import 'package:crud/models/student.dart';
import 'package:crud/services/repo.dart';
import 'package:flutter/material.dart';

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
