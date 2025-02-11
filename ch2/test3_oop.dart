class User {
  String? name;
  int? age;
  //멤버 초기화.. 1
  // User(String name, int age){
  //   this.name = name;
  //   this.age = age;
  // }
  //멤버 초기화... 2... 매개변수로.. 멤버를 바로 초기화 하면 된다면..
  // User(this.name, this.age);
  //멤버 초기화...3... 초기화 영역이용... 매개변수를 활용해서.. 약간의 로직(여러 라인 안된다..)으로 초기화..
  User(String name, int age): this.name = name.toUpperCase(), this.age = age * 2;

  //named constructor...
  User.one(){}
  User.two(String name, int age){}
  User.three(this.name, this.age);
  //다른 생성자 호출,,  this(), super() - 초기화 영역에... 하나만..
  User.four(String name, int age): this.one();
}

class Singleton {
  int data = 0;
  //객체 생성 생성자를 private 으로 선언해서.. 외부에서 직접 생성하지 못하게하고..
  Singleton._privateConstructor();
  static final Singleton _instance = Singleton._privateConstructor();
  //factory 생성자도 생성자이다.. 외부에서 객체생성에 이용할 수 있다..
  //객체 생성시점에 호출되기는 하지만.. 호출 자체로.. 객체가 만들어지지는 않는다..
  //개발자 알고리즘으로.. 적절한 객체를 준비해서.. 리턴해줘야...
  factory Singleton(){
    return _instance;
  }
}

class MyClass {
  int no;
  MyClass(this.no);
  String sayHello(String who){
    return 'hell $who';
  }
}
//상속관계로.. 클래스 이용...
class SubClass extends MyClass {
  SubClass(int no): super(no);
}
//클래스를 interface 로....
//생성자 제외.. 생성자는 클래스의 멤버가 아니다.. 멤버 모두 오버라이드..
class InterfaceTest implements MyClass {
  int no = 10;
  @override
  String sayHello(String who) {
    return 'hello';
  }
}

//mixin.....................
class A {}
//mixin 이 어떤 클래스를 설계한다는 측면은 아니지만..
//mixin 을 사용할 수 있는 클래스를 한정짓고 싶다면...
//on.... 이 타입으로 표현될 수 있는 클래스에서만 사용하라..
mixin MyMixin on A{
  int mixinData = 10;
  void mixinFun(){}
}
class MixinTest extends A with MyMixin {
  void some(){
    //with 로 선언한 믹스인의 멤버를 자신 멤버로..
    mixinData++;
    mixinFun();
  }
}

main(){
  Singleton obj1 = Singleton();
  Singleton obj2 = Singleton();
  obj1.data = 10;
  obj2.data = 20;
  print('${obj1.data}, ${obj2.data}');
}