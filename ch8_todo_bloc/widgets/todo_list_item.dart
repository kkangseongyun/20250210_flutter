import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/todosState.dart';
import '../blocs/todosBloc.dart';
import '../events/events.dart';


class TodoListItem extends StatelessWidget {
  final Todo todo;

  TodoListItem({required this.todo});

  @override
  Widget build(BuildContext context) {
    //add.....................
    TodosBloc bloc = BlocProvider.of<TodosBloc>(context);

    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (bool? checked) {
          //add.....................
          //bloc 에 이벤트 발생..
          bloc.add(ToggleTodoEvent(todo));
        },
      ),
      title: Text(todo.title),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
        onPressed: () {
          //add.........................
          bloc.add(DeleteTodoEvent(todo));
        },
      ),
    );
  }
}
