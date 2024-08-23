import 'package:crud/models/student.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class StudentsState extends Equatable {}

class StudentsLoadingState extends StudentsState {
  @override
  List<Object?> get props => [];
}

class StudentsLoadedState extends StudentsState {
  final List<StudentModel> student;
  StudentsLoadedState(this.student);
  @override
  List<Object?> get props => [student];
}

class StudentsErrorState extends StudentsState {
  final String errorMessage;
  StudentsErrorState(this.errorMessage);
  @override
  List<Object?> get props => [errorMessage];
}
