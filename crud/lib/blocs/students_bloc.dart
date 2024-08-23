import 'dart:async';

import 'package:crud/blocs/students_event.dart';
import 'package:crud/blocs/students_state.dart';
import 'package:crud/services/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsBloc extends Bloc<StudentEvent, StudentsState> {
  final StudentRepo _studentRepository;

  StudentsBloc(this._studentRepository) : super(StudentsLoadingState()) {
    on<StudentsLoadingEvent>(loadStudents);
    on<StudentsRefreshEvent>(loadStudents);
  }

  FutureOr<void> loadStudents(event, emit) async {
    emit(StudentsLoadingState());
    try {
      final students = await _studentRepository.getStudents();
      emit(StudentsLoadedState(students));
    } catch (e) {
      emit(StudentsErrorState(e.toString()));
    }
  }
}
