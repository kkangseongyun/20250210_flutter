import 'package:flutter/material.dart';

//bloc 에 의해 관리되는 상태
class Todo {
  String title;
  bool completed;
  Todo({required this.title, this.completed = false});

  void toggleCompleted(){
    completed = !completed;
  }
}
//특별한 작성규칙이 있지 않다..
class TodosState {
  List<Todo> todos;
  TodosState(this.todos);
}

