import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  List datas = [];

  //ListView 에 설정.. 유저 스크롤 정보가 자동으로 controller 에 저장..
  //마지막 항목까지 스크롤 된건지.. 판단할 때 활용 가능...
  ScrollController controller = ScrollController();

  //서버 전송 데이터..
  int page = 1;
  int seed = 1;

  //서버에 요청하는 개발자 함수.. 요청 순간이 여러번이어서...
  //함수를 호출하고.. 그 함수의 리턴 타입이 Future 이면 호출한 곳은 대기하지 않고.. 움직인다..
  Future<List<dynamic>> dioTest() async {
    try{
      //이 dio 객체를 이용해서 네트워킹 하면 매개변수에 설정된 option 이 항상 적용...
      var dio = Dio(
        BaseOptions(
          connectTimeout: Duration(seconds: 5),
          receiveTimeout: Duration(seconds: 5),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.acceptHeader: 'application/json'
          }
        )
      );

      //네트워킹...
      //함수에서  await 를 사용하려면.. 함수 선언부분이 async 로 선언되어 있어야 하고..
      //async 로 선언된 함수의 리턴 타입은 Future 이어야 하고..
      Response<dynamic> response = await dio.get(
        'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20'
      );
      return response.data['results'];//results... 서버에서 전달되는 데이터의 key
    }catch (e){
      print(e);
    }
    return [];
  }

  //스크롤 이벤트 콜백 함수...
  scrollListener() async {
    if(controller.offset >= controller.position.maxScrollExtent
        && !controller.position.outOfRange){
      //마지막까지.. 스코롤 된 상황...
      page++;
      List result = await dioTest();
      setState(() {
        datas.addAll(result);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(scrollListener);
    //최초 데이터 획득..
    dioTest().then((value){
      setState(() {
        datas = value;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  //맨 위에서 거꾸로 스크롤 했을때..
  Future<void> refresh() async {
    page = 1;
    seed++;
    List result = await dioTest();
    setState(() {
      datas = result;
    });
  }
 


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Test'),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            controller: controller,
            itemCount: datas.length,
            itemBuilder: (BuildContext context, int position) {
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                    "${datas[position]["name"]["first"]} ${datas[position]["name"]["last"]}"),
                subtitle: Text(datas[position]["email"]),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child:
                        Image.network(datas[position]["picture"]['thumbnail']),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position) {
              return Divider(
                color: Colors.black,
              );
            },
          ),
        ),
      ),
    );
  }
}
