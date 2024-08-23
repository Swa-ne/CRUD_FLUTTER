import 'dart:convert';

import 'package:crud/models/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiUrl = dotenv.env['API_URL'];

class StudentRepo {
  Future<List<StudentModel>> getStudents() async {
    var response = await http.get(Uri.parse('$apiUrl/students'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      List<dynamic> studentJSON = data['message'] ?? [];

      List<StudentModel> students =
          studentJSON.map((json) => StudentModel.fromJson(json)).toList();

      return students;
    } else {
      const SnackBar(content: Text("Server Error"));
      throw Exception('Failed');
    }
  }

  Future<StudentModel> postStudent(String firstName, String lastName,
      String course, String year, bool enrolled) async {
    final response = await http.post(
      Uri.parse("$apiUrl/add"),
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'course': course,
        'year': year,
        'enrolled': enrolled.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      dynamic studentJSON = data['message'];

      StudentModel students = StudentModel.fromJson(studentJSON);
      return students;
    } else {
      const SnackBar(content: Text("Server Error"));
      throw Exception('Failed');
    }
  }

  Future<StudentModel> putStudent(String firstName, String lastName,
      String course, String year, bool enrolled, String id) async {
    print("$apiUrl/update/$id");
    final response = await http.put(
      Uri.parse("$apiUrl/update/$id"),
      body: {
        'first_name': firstName,
        'last_name': lastName,
        'course': course,
        'year': year,
        'enrolled': enrolled.toString(),
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      dynamic studentJSON = data['message'];

      StudentModel students = StudentModel.fromJson(studentJSON);
      return students;
    } else {
      const SnackBar(content: Text("Server Error"));
      throw Exception('Failed');
    }
  }

  Future<void> deleteStudent(String id) async {
    try {
      final response = await http.delete(Uri.parse('$apiUrl/delete/$id'));

      if (response.statusCode == 200) {
        const SnackBar(content: Text("Success"));
      } else {
        const SnackBar(content: Text("Server Error"));
      }
    } catch (e) {
      const SnackBar(content: Text("Server Error"));
    }
  }
}
