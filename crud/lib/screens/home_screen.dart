import 'package:crud/blocs/form_bloc.dart';
import 'package:crud/blocs/students_bloc.dart';
import 'package:crud/blocs/students_event.dart';
import 'package:crud/blocs/students_state.dart';
import 'package:crud/screens/bottom_sheet.dart';
import 'package:crud/services/repo.dart';
import 'package:crud/widgets/student_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _onRefresh() async {
    context.read<StudentsBloc>().add(StudentsRefreshEvent());
  }

  void _fabOnPressed() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => BlocProvider(
        create: (context) => FormBloc(StudentRepo()),
        child: const BottomSheetWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<StudentsBloc, StudentsState>(
          builder: (context, state) {
            if (state is StudentsLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is StudentsLoadedState) {
              if (state.student.isEmpty) {
                return const Text("No student in the database");
              }
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: StudentList(students: state.student),
              );
            }
            if (state is StudentsErrorState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fabOnPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
