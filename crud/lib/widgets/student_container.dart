import 'package:crud/models/student.dart';
import 'package:crud/screens/student_page.dart';
import 'package:flutter/material.dart';

class StudentListContainer extends StatelessWidget {
  const StudentListContainer({super.key, required this.student});
  final StudentModel student;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentPage(student: student),
            ),
          );
        },
        child: ListTile(
          title: Text(
            '${student.firstName} ${student.lastName}',
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${student.year} - ${student.course}'),
              Text(student.enrolled ? "Currently Enrolled" : "Not Enrolled")
            ],
          ),
        ),
      ),
    );
  }
}
