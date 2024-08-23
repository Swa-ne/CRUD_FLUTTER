import 'package:crud/blocs/students_bloc.dart';
import 'package:crud/blocs/students_event.dart';
import 'package:crud/screens/home_Screen.dart';
import 'package:crud/services/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: BlocProvider(
          create: (context) =>
              StudentsBloc(StudentRepo())..add(StudentsLoadingEvent()),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
