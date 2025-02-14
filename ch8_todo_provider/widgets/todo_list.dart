import 'package:flutter/material.dart';
import 'package:flutter_lab4/ch8_todo_provider/widgets/todo_list_item.dart';
import '../models/todo.dart';



class TodoList extends StatelessWidget {
  List<Todo> todos;

  TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: getChildrenTodos(),
    );
  }

  //add...................
  List<Widget> getChildrenTodos() {
    return todos.map((todo) => TodoListItem(todo)).toList();
  }
}
