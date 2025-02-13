import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'four_screen.dart';
import 'one_screen.dart';
import 'three_screen.dart';
import 'two_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //라우팅 정보는 어디서 등록하든 상관이 없다... 보통의 경우 가장 첫번째 실행되는 곳에서 등록한다..
      //여러군데 등록해도 된다..
      //MyApp(전체) -> UserMain(회원화면 등록)
      initialRoute: '/',
      routes: {
        '/': (context) => OneScreen(),
        '/two': (context) => TwoScreen(),
      },
      //라우팅 명령이 내려진 순간.. 등록된 Route 로 화면 전환만 되면 된다면.. routes 에 등록..
      //약간의 로직이 동반되어 화면 전환이 되어야 한다면..
      //매개변수는 어디선가 화면전환시 요청했을때 설정된 정보..이름.. 데이터..
      onGenerateRoute: (settings){
        if(settings.name == '/three'){
          //적절한 알고리즘 실행하고...
          //이곳에서 리턴시킨 Route 에 의해 화면전환이 된다..
          return MaterialPageRoute(
              builder: (context) => ThreeScreen(),
              settings: settings,//자신이 받은 정보를 그대로 설정해서.. 전환되는 화면에서도 사용하게..
            //정보에 넘기는 데이터가 있을 수 있어서... 원한다면 데이터 교체, 추가도 가능하고..
          );
          //route 와 onGenerateRoute 에 동일한 이름의 라우팅 정보가 설정되어 있다면..onGenerateRoute
          //가 적용..
        }else if(settings.name == '/four'){
          return MaterialPageRoute(
            builder: (context) => FourScreen(),
            settings: settings,
          );
        }
      },
    );
  }
}