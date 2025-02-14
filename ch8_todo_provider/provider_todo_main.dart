import 'package:flutter/material.dart';
import 'package:flutter_lab4/ch8_todo_provider/providers/todos_model.dart';
import './screens/home_screen.dart';
import 'package:provider/provider.dart';



void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //add.................................
    return ChangeNotifierProvider(
        create: (context) => TodosModel(),
        child: MaterialApp(
          home: HomeScreen(),
        ),
    );
  }
}