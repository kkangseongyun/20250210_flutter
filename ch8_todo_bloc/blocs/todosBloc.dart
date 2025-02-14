import 'package:bloc/bloc.dart';
import '../events/events.dart';
import '../states/todosState.dart';

//이 객체를 상위 어디선가 등록, 하위에서 이용..
//제네릭 타입, 자신들이 감지하는 이벤트 타입 - 자신들이 발행하는 상태 타입..
class TodosBloc extends Bloc<TodosEvent, TodosState>{
  //상위 생성자 호출의 매개변수... 상태 초기값..
  TodosBloc(): super(TodosState([])){
    //이벤트 등록.. 제네릭 타입으로.. 이벤트 타입 명시..
    //emit - 신규 상태를 발행하는 함수..
    on<AddTodoEvent>((event, emit){
      //state 는 이 이벤트가 발생하기전 bloc 에서 유지하고 있는 상태 데이터..
      List<Todo> newTodos = List.from(state.todos)
          ..add(event.todo);
      emit(TodosState(newTodos));
    });
    on<DeleteTodoEvent>((event, emit){
      List<Todo> newTodos = List.from(state.todos)
          ..remove(event.todo);
      emit(TodosState(newTodos));
    });
    on<ToggleTodoEvent>((event, emit){
      //상태는 불변이다.이전 상태를 변경하는 거이 아니라.. 이전 상태를 참조해서.. 새로운 상태를 만드는 것이다.
      List<Todo> newTodos = List.from(state.todos);
      int index = newTodos.indexOf(event.todo);
      newTodos[index].toggleCompleted();
      emit(TodosState(newTodos));
    });
  }
  //이벤트 발생시마다.. 로그 전달 목적으로 호출...
  @override
  void onTransition(Transition<TodosEvent, TodosState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}