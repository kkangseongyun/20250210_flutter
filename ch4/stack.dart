import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() => runApp(MyApp());

//이벤트 내용 추상화 VO
class DataVO {
  String image;
  String title;
  String date;
  String content;
  String location;
  DataVO(this.image, this.title, this.date, this.content, this.location);
}

List<DataVO> datas = [
  DataVO('images/lab_lotte_1.jpg', '롯데웨딩위크', '각 지점 본 매장', '2.14(금) ~ 2.23(일)',
      '백화점 전점'),
  DataVO('images/lab_lotte_2.jpg', 'LG TROMM 스타일러', '각 지점 본 매장',
      '2.14(금) ~ 2.29(토)', '백화점 전점'),
  DataVO(
      'images/lab_lotte_3.jpg', '금양와인 페스티발', '본매장', '2.15(토) ~ 2.20(목)', '잠실점'),
  DataVO('images/lab_lotte_4.jpg', '써스데이 아일랜드', '본 매장', '2.17(월) ~ 2.23(일)',
      '잠실점'),
  DataVO('images/lab_lotte_5.jpg', '듀풍클래식', '본 매장', '2.21(금) ~ 3.8(일)', '잠실점'),
];

//이벤트 하나를 출력하기 위한 위젯...
class CardWidget extends StatelessWidget {
  DataVO vo;
  CardWidget(this.vo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(//전체 영역을 색상으로 칠하고..
          color: Colors.pink,
        ),
        Align(//위치 조정해서..
          alignment: Alignment(0.0, 0.0),//center
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,//content 를 출력할 정도의 사이즈만..
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    vo.image,
                    width: 350,
                  ),
                  Container(
                    width: 350,
                    height: 100,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vo.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text(vo.content),
                        Text(vo.date),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                left: 30,
                bottom: 90,
                child: Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.black,
                  child: Text(vo.location, style: TextStyle(color: Colors.white),),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
//PageView(화면을 손가락 따라서 하나씩..) 때문에 statefull....
class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}
class MyWidgetState extends State<MyWidget>{
  //build 에서 호출할 거다.. 데이터 갯수 만큼.. 화면 출력 위젯 객체를 생성하기 위한 개발자 함수..
  List<CardWidget> makeWidgets() {
    return datas.map((vo){
      return CardWidget(vo);
    }).toList();
  }
  //PageView 에 지정할 값.. PageView 가 어떻게 움직이면 된다는 설정.. PageView 에 의한 화면 조정 정보가 자동
  //설정 되는 곳..
  PageController controller = PageController(
    initialPage: 0,
    viewportFraction: 0.9,//1.0 이면 현 화면의 왼쪽 오른쪽이 안나오고.. 1.0 보다 작게 설정하면 같이 나오고..
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller,
            children: makeWidgets(),
          ),
        ),
        SmoothPageIndicator(
            controller: controller,
            count: 5,
            effect: WormEffect(
              dotColor: Colors.white,
              activeDotColor: Colors.indigo
            ),
            onDotClicked: (index){},
        ),
        SizedBox(height: 32.0,)
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body: Container(
          color: Colors.pink,
          child: MyWidget(),
        )
      ),
    );
  }
}

