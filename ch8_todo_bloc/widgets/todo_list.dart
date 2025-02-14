import 'package:flutter/material.dart';
import '../states/todosState.dart';
import 'todo_list_item.dart';





class TodoList extends StatelessWidget {
  final List<Todo> todos;

  TodoList({required this.todos});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTodos(),
    );
  }

  //add...................
  List<Widget> getChildrenTodos(){
    return todos.map((todo) => TodoListItem(todo: todo)).toList();
  }

}
