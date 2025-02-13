import 'package:flutter/material.dart';

//유저 입력 데이터 추상화..
class User {
  String? firstName;
  String? lastName;
}

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormWidgetState();
  }
}
class FormWidgetState extends State<FormWidget>{
  //임의 순간.. StatefulWidget 의 State 객체를 직접 획득해서 작업하려면 key 매핑해야 한다..
  //이 목적의 키는 GlobalKey 만 가능하다...
  //Form 에 설정.. Form 의 State 를 획득해서 유효성검증, 데이터 저장 명령을 내릴려고..
  var formKey = GlobalKey<FormState>();
  var user = User();

  //모두 유효한 경우.. 호출.. 입력 데이터 처리...
  save() {
    print('save().... ${user.firstName}, ${user.lastName}');
  }

  @override
  Widget build(BuildContext context) {
    //유저 입력에 필수는 아니다.. 유효성 검증.. 데이터 획득에 도움이 필요하다면..
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Form 을 이용하면 Form 과 연동 준비가 되어 있는 TextFormField 를 사용해야..
          TextFormField(
            decoration: InputDecoration(labelText: 'first name'),
            //Form State 의 validate() 호출하는 순간.. 개별 field 의 validator 함수가 자동 호출..
            //매개변수는 현재 유저가 입력한 데이터..
            validator: (value){
              if(value?.isEmpty ?? false){
                //문자열 리턴.. invalid.. 에러메시지다..
                return 'please enter your first name';
              }
              return null;//valid 상황...
            },
            //Form State 의 save() 호출시 자동 호출.. 매개변수는 입력 데이터...
            onSaved: (value) {
              setState(() {
                user.firstName = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'last name'),
            validator: (value){
              if(value?.isEmpty ?? false){
                return 'please enter your last name';
              }
              return null;//valid 상황...
            },
            onSaved: (value) {
              setState(() {
                user.lastName = value;
              });
            },
          ),
          ElevatedButton(
              onPressed: (){
                //Form 의 State 를 key 로 획득..
                //key.currentState
                var form = formKey.currentState;
                //Form 하위의 모든 filed validator 에 등록한 함수가 호출된다..
                //모두 null 을 리턴하면 전체 유효, true... 하나라도 null  이 아니면 전체 invalid, false
                if(form?.validate() ?? false){
                  form?.save();//Form 하위의 모든 field 의 onSave 함수 호출..
                  save();
                }
              },
              child: Text('save'),
          ),
        ],
      ),
    );
  }
}









