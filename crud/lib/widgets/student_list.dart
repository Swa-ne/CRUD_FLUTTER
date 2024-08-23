import 'package:crud/models/student.dart';
import 'package:crud/widgets/student_container.dart';
import 'package:flutter/material.dart';

class StudentList extends StatelessWidget {
  const StudentList({super.key, required this.students});

  final List<StudentModel> students;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: students.length,
      itemBuilder: (_, index) => StudentListContainer(student: students[index]),
      separatorBuilder: (context, index) => const SizedBox(),
    );
  }
}
