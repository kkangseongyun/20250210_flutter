import 'package:flutter/material.dart';
import 'user.dart';

class OneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('OneScreen'),
          ),
          body: Container(
            color: Colors.red,
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('OneScreen', style: TextStyle(color: Colors.white,fontSize: 30),),
                    ElevatedButton(
                      onPressed: () async{
                        //화면 전환시키고.. pop 시 결과 데이터 전달받고자 한다..
                        //리턴 값은 되돌아 올때 전달되는 값..
                        var result = await Navigator.pushNamed(
                            context,
                            '/two',
                            arguments: {//화면 전환시 넘길 데이터..
                              'arg1': 10,
                              'arg2': 'hello',
                              'arg3': User('kim', 'seoul')
                            }
                        );
                        print('result data : ${(result as User).name}');
                       
                      },
                      child: Text('Go Two'),
                    )
                  ],
                )
            ),
          ),
        )
    );
  }
}