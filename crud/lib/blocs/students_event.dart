import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class StudentEvent extends Equatable {
  const StudentEvent();
}

class StudentsLoadingEvent extends StudentEvent {
  @override
  List<Object?> get props => [];
}

class StudentsRefreshEvent extends StudentEvent {
  @override
  List<Object?> get props => [];
}
