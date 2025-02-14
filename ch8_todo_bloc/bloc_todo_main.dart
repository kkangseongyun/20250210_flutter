import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/todosBloc.dart';
import 'screens/home_screen.dart';


void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //add.................................
    return BlocProvider<TodosBloc>(
      create: (context) => TodosBloc(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}