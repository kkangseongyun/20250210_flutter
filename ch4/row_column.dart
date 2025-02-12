import 'package:flutter/material.dart';
import 'package:flutter_lab4/ch4/widgets/content_widget.dart';
import 'package:flutter_lab4/ch4/widgets/header_widget.dart';
import 'package:flutter_lab4/ch4/widgets/icon_widget.dart';
import 'package:flutter_lab4/ch4/widgets/image_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        ////위젯으로 화면을 구성하다가 화면을 벗어나면(세로, 가로) 알아서 경고 패턴(노란색 검정색)
        //스크롤 준비하지 않았다는 의미... 자동 스크롤 지원하지 않는다.. 개발자가 준비해주어야..
        //SingleChildScrollView - 위젯 하나를 child 에 등록하고.. 그 위젯을 스크롤 시킬때..
        //ListView - 위젯 여러개를 등록 같이 스크롤...
        body: SingleChildScrollView(
          child: Column(
            children: [
              HeaderWidget(),
              ImageWidget(),
              IconWidget(),
              ContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

