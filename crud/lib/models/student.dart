class StudentModel {
  final String id;
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  StudentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.course,
    required this.year,
    required this.enrolled,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      course: json['course'],
      year: json['year'],
      enrolled: json['enrolled'],
    );
  }
}
