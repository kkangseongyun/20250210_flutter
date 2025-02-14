import 'package:flutter/material.dart';
import 'package:flutter_lab4/ch8_todo_provider/providers/todos_model.dart';

import 'package:provider/provider.dart';

import '../widgets/todo_list.dart';
import '../models/todo.dart';
import 'add_screen.dart';

class TabScreen extends StatelessWidget {

  List<Todo> todos;
  TabScreen(this.todos);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TodoList(this.todos),
    );
  }
}


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {//tab 화면 전환 animation

  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);//animation
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Active'),
            Tab(text: 'Complete'),
          ],
        ),
      ),
      //add........................
      body:
        Consumer<TodosModel>(
          //제네릭 타입으로 명시된 provider data 가 두번째 배개변수로 전달.. provider 를 받아서 화면구성하기
          //용읻...
            builder: (context, model, child){
              //TabBar - TabBarView
              //이벤트 처리하지 않고.. 두 위젯이 동일 controller 로 연결만 되어 있다면..
              //index 로...
              return TabBarView(
                  controller: controller,
                  children: [
                    TabScreen(model.todos),
                    TabScreen(model.todos.where((todo) => !todo.completed).toList()),
                    TabScreen(model.todos.where((todo) => todo.completed).toList()),
                  ]
              );
            }
        ),
      
    );
  }
}
