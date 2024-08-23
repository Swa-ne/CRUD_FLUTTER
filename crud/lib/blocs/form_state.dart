import 'package:crud/models/student.dart';
import 'package:flutter/material.dart';

@immutable
abstract class FormsState {}

class FormInitial extends FormsState {}

class FormLoading extends FormsState {}

class FormLoaded extends FormsState {
  final StudentModel student;

  FormLoaded(this.student);
}

class FormError extends FormsState {}
