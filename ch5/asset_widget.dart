import 'package:flutter/material.dart';
import 'dart:convert';//json parser...
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetWidget extends StatelessWidget {
  //build 함수에서 호출.. text asset 을 읽어들여 문자열을 구성하는 함수..
  Widget makeTextWidget(context){
    //시간이 오래 걸리는 작업..(network, file) 을 기다렸다가.. 그 데이터로 화면을 구성하기는 성능상 부담스럽다.
    //무조건 빠르게 화면 출력하고... 나중에 데이터가 발생했을때 화면을 업데이트 하는 식으로...
    //비동기 처리가 되어야 한다..
    //Future - 시간이 오래 걸려서 발생하는 데이터를 의미..
    //FutureBuilder - Future 에서 데이터가 발생하기를 대기했다가.. 실제 데이터가 발생하는 순간.. 그 데이터로
    //화면을 구성해주는 위젯...
     return FutureBuilder(
        //미래에 발생하는 데이터 지정...
         future: DefaultAssetBundle.of(context).loadString('assets/text/my_text.txt'),
         //화면 구성을 위해서 호출되는 함수.. 이 함수에서 리턴시킨 것이 화면이다..
         //최초에 한번 - Future 가 데이터를 발생하지 않은 시점..
         //Future 에서 데이터가 발생하는 순간 호출.. 두번째 매개변수가.. 발생한 데이터이다..
         builder: (context, snapshot){
           if(snapshot.hasData){
             return Text('load text : ${snapshot.data}');
           }
           return Text('');
         }
     );
  }

  Widget makeJsonWidget(context){
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/data.json'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            //json parsing...
            var root = json.decode(snapshot.data.toString());
            return Text('json data : ${root[0]['name']}');
          }
          return Text('');
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Image(위젯) - ImageProvider(데이터 획득)
        //asset varients 테스트... icon 까지만 지정했다.. 그 하위 폴더는 알아서 자동 선택..
        Image(image: AssetImage('assets/icon/user.png'),),
        //named constructor 사용해서.. 위와 동일..
        Image.asset('assets/icon/user.png'),
        makeTextWidget(context),
        makeJsonWidget(context),
        //flutter icon... 앱 빌드시에.. 다운로드 되어 실제 런타임시에는 로컬이다..
        Icon(Icons.menu),
        Icon(FontAwesomeIcons.music, size: 30, color: Colors.pink,),
      ],
    );
  }
}