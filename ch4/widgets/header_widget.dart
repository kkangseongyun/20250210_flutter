import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//popup menu 구성 문자열..
List<String> choices = [
  '신고',
  '알림 설정',
  '공유하기'
];

class HeaderWidget extends StatelessWidget {
  //메뉴 선택 이벤트 콜백..
  void select(String choice){
    Fluttertoast.showToast(
        msg: choice,
        toastLength: Toast.LENGTH_SHORT,//사라지는 시간..
        gravity: ToastGravity.BOTTOM,//platform 에 따라 적용안될 수도 있다..
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('images/lab_instagram_icon_0.jpg'),
        //위젯이 나오는 특정 영역을 구성하기 위한(칼라, 사이즈 등등)
        Container(
          padding: EdgeInsets.only(left: 16),//only - 단일 방향, all(4 방향)
          child: Text('instagram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        ),
        Spacer(),//여백만 차지하는 위젯...
        PopupMenuButton(
            onSelected: select,//메뉴선택 이벤트...
            //초기에는 ... 으로만 나오다가 ... 클릭시에 알아서 확장되면서 메뉴가 보인다..
            //메뉴 부분을 어떻게 꾸밀지를 결정하기 위해서 자동 호출되는 함수..
            //이 함수에서 리턴 시킨 부분이 메뉴로 나온다..
            itemBuilder: (BuildContext context){
              return choices.map<PopupMenuItem<String>>((String choice){
                return PopupMenuItem(
                    child: Text(choice),
                    value: choice,//해당 메뉴를 클릭했을 때 콜백 함수에 전달할 값..
                );
              }).toList();
            }
        ),
      ],
    );
  }
}