import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/todo.dart';

//provider 에 의해 공개되는 데이터..
class TodosModel extends ChangeNotifier {
  List<Todo> todos = [];

  void addTodo(Todo todo){
    todos.add(todo);
    notifyListeners();//변경사항 하위 적용...
  }
  void toggleTodo(Todo todo){
    var index = todos.indexOf(todo);
    todos[index].toggleCompleted();
    notifyListeners();
  }
  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
}
