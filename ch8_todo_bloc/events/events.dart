import '../states/todosState.dart';

//bloc 에 발생시킬 이벤트..
//특별 작성규칙이 없다.. 타입으로 식별되게만 하면 된다..
//이벤트 발생시에 bloc 에 넘길 데이터가 없으면 enum, 있으면 클래스..
abstract class TodosEvent {}
class AddTodoEvent extends TodosEvent{
  Todo todo;
  AddTodoEvent(this.todo);
}
class DeleteTodoEvent extends TodosEvent {
  Todo todo;
  DeleteTodoEvent(this.todo);
}
class ToggleTodoEvent extends TodosEvent {
  Todo todo;
  ToggleTodoEvent(this.todo);
}