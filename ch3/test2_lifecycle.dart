import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() {
  runApp(MyApp());
}

//최 상위 위젯을 stateful 로 만드는 것은 권장할만 하지는 않지만.. 테스트 용이성을 위해서..
//이 위젯의 상태 변경시에.. 하위 위젯의 라이프사이클을 살펴보고자 한다..
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}
class MyAppState extends State<MyApp> {
  int count = 0;//상위에서 유지하는 상태 데이터라는 가정.. 이 값 변경 순간의 하위 위젯의 라이프사이클..

  void increment() {
    setState(() {
      count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lifecycle test'),
        ),
        //Provider... 상위의 상태를 하위에 전파시킬 목적으로...
        body: Provider.value(
            value: count,
            child: Column(
              children: [
                Row(
                  children: [
                    Text('I am Parent Widget'),
                    ElevatedButton(
                        onPressed: increment,
                        child: Text('Increment')
                    )
                  ],
                ),
                MyChildWidget(),
              ],
            ),
        ),
      ),
    );
  }
}
class MyChildWidget extends StatefulWidget {
  MyChildWidget(){
    print('MyChildWidget constructor...');
  }
  @override
  State<StatefulWidget> createState() {
    return MyChildState();
  }
}
//WidgetsBindingObserver - 앱의 라이프사이클 감지하기 위해서...
class MyChildState extends State<MyChildWidget> with WidgetsBindingObserver{
  int count = 0;//상위 상태 데이터... 전달받아서 활용..

  MyChildState(){
    print('MyChildState constructor...');
  }
  @override
  void initState() {
    super.initState();
    print('MyChildState initState....');
    //객체 생성후 최초 한번.. 주로 상태값 초기화, 이벤트 등록...
    //앱의 라이프 사이클 이벤트 콜백 등록..
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void dispose() {
    super.dispose();
    //state 객체 소멸 직전에 최후에 한번..
    //어떤 리소스 release, 이벤트 등록 해제...
    WidgetsBinding.instance.removeObserver(this);
  }
  //최초에 initState 호출후 호출..
  //그 후에. 상위 상태 변경시마다..
  //단순 상위 상태를 받기 위한 용도라면 굳이 오러라이드 하지 않아도 된다..
  //뭔가 로직이 실행되거나 할때..
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('MyChildState didChangeDependencies..');
    count = Provider.of<int>(context);//상위 상태 얻는 것은 이 위치가 아니라 build 도 가능하기는 하다.
  }
  @override
  Widget build(BuildContext context) {
    print('MyChildState build...');
    return Text('I am Child Widget : $count');
  }
  //앱 라이프사이클 변경사 콜백..
@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('app lifecycle : $state');
  }
}

//최초....
// I/flutter ( 8215): MyChildWidget constructor...
// I/flutter ( 8215): MyChildState constructor...
// I/flutter ( 8215): MyChildState initState....
// I/flutter ( 8215): MyChildState didChangeDependencies..
// I/flutter ( 8215): MyChildState build...

//상위 상태 변경 순간...
//위젯은 불변이다.. 위젯은 다시 생성된다.. state 객체의 생성자 로그는 찍히지 않았다.
// I/flutter ( 8215): MyChildWidget constructor...
// I/flutter ( 8215): MyChildState didChangeDependencies..
// I/flutter ( 8215): MyChildState build...

//앱의 라이프사이클 변경...앱이 화면에서 사라질대..
// /I/flutter ( 8215): app lifecycle : AppLifecycleState.inactive
// I/flutter ( 8215): app lifecycle : AppLifecycleState.hidden
// I/flutter ( 8215): app lifecycle : AppLifecycleState.paused

//다시 앱이 나올때...
//I/flutter ( 8215): app lifecycle : AppLifecycleState.hidden
// I/flutter ( 8215): app lifecycle : AppLifecycleState.inactive
// I/flutter ( 8215): app lifecycle : AppLifecycleState.resumed