import 'package:flutter/material.dart';
import 'package:flutter_lab4/ch5/asset_widget.dart';
import 'package:flutter_lab4/ch5/form_widget.dart';

void main() => runApp(MyApp());

//bottom navigation bar 제어를 목적으로.. stateful
class MyApp extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp>{
  int selectedIndex = 0;//상태 데이터.. navigationbar 클릭 위치

  List<Widget> widgets = [
    AssetWidget(),
    FormWidget()
  ];
  //bottom tab button click.....
  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.black,
        )
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget Test'),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: Container(
                height: 48.0,
                alignment: Alignment.center,
                child: Text('AppBar Bottom Text'),
              )
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/big.jpeg'),
                  fit: BoxFit.fill,
              ),
            ),
          ),
          actions: [//메뉴.. 이벤트 처리...
            IconButton(onPressed: (){}, icon: Icon(Icons.add_alarm)),
            IconButton(onPressed: (){}, icon: Icon(Icons.add_alert)),
          ],
        ),
        body: Center(
          child: widgets.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,//버튼 클릭시 그 버튼에 지정된 칼라로 전체 백그라운드 칼라지정
            //fixed 효과 안먹고..
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Colors.green,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'two',
                backgroundColor: Colors.red,
              ),
            ],
            currentIndex: selectedIndex,
            selectedItemColor: Colors.amber,//탭 버튼 여러개중에서 현재 선택된 버튼의 색상을 다르게...
            onTap: onItemTapped,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                  child: Text('Drawer Header...'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
              ),
              ListTile(
                title: Text("Item 1"),
                onTap: (){},
              ),
              ListTile(
                title: Text("Item 1"),
                onTap: (){},
              ),
              ListTile(
                title: Text("Item 1"),
                onTap: (){},
              )
            ],
          ),
        ),
      ),
    );
  }
}

