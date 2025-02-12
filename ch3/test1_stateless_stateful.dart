
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

main(){
  runApp(MyApp());
}

//위젯 트리의 최상위 위젯은 일반적으로.. stateless
//stateful 로 만든다면 화면 re-rendering 시에 너무 많은 위젯이 다시 생성이 되어서..
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //보통의 경우.. 위젯 트리의 상위에 MaterialApp 을 이용해서.. 머티리얼 디자인에 입각한
    //화면구성의 도움을 받는다.. 테마 설정, navigation 처리등..
    //일반적으로 MaterialApp 을 트리의 상위에 위치시키지만.. 필수는 아니다..
    //안드로이드 UI 효과로 나온다.. 만약.. ios UI 효과로 출력되게 할려면 CupertinoApp 을 사용하는 경우
    //도 있다..
    return MaterialApp(
      //화면의 기본적인 구성..appbar, body, drawer, fab, bottom navigation bar
      home: Scaffold(
        appBar: AppBar(
          title: Text("widget test"),
        ),
        body: Column(
          children: [
            MyStatelessWidget(),
            MyStatefulWidget(),
          ],
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  //stateless 도 얼마든지 데이터를 가질 수 있고.. 데이터를 변경 시킬 수 있다..
  bool favorited = false;
  int favoriteCount = 10;

  void toggle(){
    print('stateless toggle....');
    if(favorited){
      favoriteCount -= 1;
      favorited = false;
    }else {
      favoriteCount += 1;
      favorited = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    print('stateless build....');
    return Row(
      children: [
        IconButton(
            onPressed: toggle,
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border))
        ),
        Text('$favoriteCount'),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  //stateful 은 꼭 state 를 가져야 하고.. 아래의 함수에서 이 위젯을 위한 state 객체를 결정해서 리턴시켜야..
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}
//State 를 상속받아 만들면 제네릭으로.. 어느 widget 의 state 인지를 타입으로 명시해야...
class MyState extends State<MyStatefulWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  void toggle(){
    print('state toggle....');
    //state 는 상태를 유지하고 상태 값이 변경되면 화면 리랜더링 가능하지만.. 변수 값 변경만으로는
    //리랜더링 되지 않는다.. setState() 로 명령 내려야...
    //매개변수 함수를 먼저 호출하고.. 그 함수가 끝나면 build 를 자동호출해서 리랜더링..
    setState(() {
      if(favorited){
        favoriteCount -= 1;
        favorited = false;
      }else {
        favoriteCount += 1;
        favorited = true;
      }
    });

  }
  @override
  Widget build(BuildContext context) {
    print('state build....');
    return Row(
      children: [
        IconButton(
            onPressed: toggle,
            icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border))
        ),
        Text('$favoriteCount'),
      ],
    );
  }
}









