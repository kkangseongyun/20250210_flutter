main(){
  //모든 변수는 객체이다....
  int data1 = 10;
  print(data1.isEven);//true

  //캐스팅은 상하위 관계에서만 논할 수 있다..
  //기초 타입의 객체 변환은 함수를 이용해야 한다..
  // double data2 = data1;//error
  double data2 = data1.toDouble();
  int data3 = 10.0.toInt();

  //string <-> int
  String data4 = '10';
  int data5 = int.parse(data4);
  String data6 = data5.toString();

  //var - 타입 유추 기법, dynamic - any 타입..
  int a = 10;
  // a = 'hello';//error
  var b = 10;//이 순간 대입되는 값에 의해 int 타입으로 고정된다...
  // b = 'hello';//error
  dynamic c = 10;//모든 타입 가능..
  c = 'hello';
  //var 로 선언하면서 초기 값을 대입하지 않았다면...
  var d;//값이 지정되지 않으면 dynamic 으로 유추...
  d = 10;
  d = 'hello';

  //List.............
  //선언과 동시에 값 지정하는 경우...
  List list1 = [10, 20, 30];
  list1[0] = 20;
  list1.add(30);
  list1.forEach((item){
    print(item);
    print(',');
  });

  //사이즈를 지정하지 않고 사용...
  List<int> a1 = [];
  a1.add(10);
  a1.add(20);

  //사이즈를 지정하고 사용할때...
  //filled 라는 생성자 이용..
  List a2 = List.filled(3, 0);//초기 값이 모두 0으로 지정...

  //이차원 배열 효과를 내고 싶을 때..
  List<List<int>> a3 = [[10, 20], [30, 40]];
  print(a3[0][0]);

  //map...
  Map map = {1:10, 'one':'hello'};
  print(map['one']);

  //null safety...........................
  int d1 = 10;//int - non-null
  int? d2 = 10;//int - nullable..

  // d1 = null;//error..
  d2 = null;//ok.....

  //nullable 로 선언된 객체는... 멤버 접근할 때 null safety operator 를 사용해 주어야..
  d1.isEven;
  d2?.isEven;

  bool? e1 = d2?.isEven;

  //null safety... casting...
  int f1 = 10;
  int? f2 = f1;//암시적 캐스팅...
  int f3 = f2 as int;//명시적 캐스팅...
}





