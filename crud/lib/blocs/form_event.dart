import 'package:flutter/material.dart';

@immutable
abstract class FormEvent {}

class SendData extends FormEvent {
  final String firstName;
  final String lastName;
  final String course;
  final String year;
  final bool enrolled;

  SendData(
    this.firstName,
    this.lastName,
    this.course,
    this.year,
    this.enrolled,
  );
}
