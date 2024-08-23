import 'dart:async';

import 'package:crud/blocs/form_event.dart';
import 'package:crud/blocs/form_state.dart';
import 'package:crud/services/repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FormBloc extends Bloc<FormEvent, FormsState> {
  final StudentRepo _studentRepository;

  FormBloc(this._studentRepository) : super(FormInitial()) {
    on<SendData>(postStudent);
    on<UpdateData>(putStudent);
  }
  FutureOr<void> postStudent(event, emit) async {
    if (event is SendData) {
      emit(FormLoading());
      try {
        await Future.delayed(const Duration(seconds: 2), () async {
          final result = await _studentRepository.postStudent(
            event.firstName,
            event.lastName,
            event.course,
            event.year,
            event.enrolled,
          );
          emit(FormLoaded(result));
        });
      } catch (e) {
        emit(FormError());
      }
    }
  }

  FutureOr<void> putStudent(event, emit) async {
    if (event is UpdateData) {
      emit(FormLoading());
      try {
        await Future.delayed(const Duration(seconds: 2), () async {
          final result = await _studentRepository.putStudent(
            event.firstName,
            event.lastName,
            event.course,
            event.year,
            event.enrolled,
            event.id,
          );
          emit(FormLoaded(result));
        });
      } catch (e) {
        emit(FormError());
      }
    }
  }
}
